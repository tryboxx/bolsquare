//
//  ContentDataSource.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

@MainActor
protocol ContentDataSourceCellProvider: AnyObject, AutoMockable {
    func dataSourceCustomCell(
        forItem item: ContentItemDefinition,
        tableView: UITableView,
        indexPath: IndexPath
    ) -> UITableViewCell?
}

@MainActor
protocol ContentDataSource: AnyObject, AutoMockable, AutoFactory {
    var cellProvider: ContentDataSourceCellProvider? { get set }
    var cellContentInsets: ContentInsets { get set }
    func setup(inTableView tableView: UITableView)
    func load(sections: [[ContentItemDefinition]])
    func load(items: [ContentItemDefinition])
    func load(sectionItems: [ContentItemDefinition], section: Int)
}

class ContentDataSourceImpl: NSObject, ContentDataSource {
    weak var cellProvider: ContentDataSourceCellProvider?

    var cellContentInsets = ContentInsets.common

    private var sections = [[ContentItemDefinition]]()

    func setup(inTableView tableView: UITableView) {
        ContentCells.register(in: tableView)
        ContentCell<EmptyContentDefinition>.register(in: tableView)

        tableView.dataSource = self
        tableView.delegate = self
    }

    func load(sections: [[ContentItemDefinition]]) {
        self.sections = sections
    }

    func load(items: [ContentItemDefinition]) {
        sections = [items]
    }

    func load(sectionItems: [ContentItemDefinition], section: Int) {
        sections[section] = sectionItems
    }
}

extension ContentDataSourceImpl: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section][indexPath.row]
        guard let cell = prepareCell(forItem: item, tableView: tableView, indexPath: indexPath) else {
            return ContentCell<EmptyContentDefinition>.cell(in: tableView)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = sections[indexPath.section][indexPath.row]

        let availableWidth = tableView.bounds.size.width
        switch item.type {
        case .header:
            guard let headerItem = item as? HeaderDefinition else { return 0 }
            return HeaderCell.estimateHeight(
                forAvailableWidth: availableWidth,
                definition: headerItem,
                contentInsets: cellContentInsets
            )
        case .labelWithValue:
            guard let labelItem = item as? LabelWithValueDefinition else { return 0 }
            return LabelWithValueCell.estimateHeight(
                forAvailableWidth: availableWidth,
                definition: labelItem,
                contentInsets: cellContentInsets
            )
        default: break
        }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let indicatorCell = cell as? IndicatorCell {
            indicatorCell.view.restartIndicator()
        }
        if indexPath.section == tableView.numberOfSections - 1,
           indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            Task {
                tableView.bringCellsToFrontBeginningFromLastCell()
            }
        }
    }
}

extension ContentDataSourceImpl {

    private func prepareCell(
        forItem item: some ContentItemDefinition,
        tableView: UITableView,
        indexPath: IndexPath
    ) -> UITableViewCell? {

        let cell: UITableViewCell? = cell(for: item, tableView: tableView, indexPath: indexPath)

        return cell
    }

    func prepare<Definition>(
        cellType: (some ContentCell<Definition>).Type,
        definition: Definition,
        tableView: UITableView,
        indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = cellType.cell(in: tableView)
        cell.configure(withDefinition: definition)

        if let definitionWithDynamicHeight = definition as? HasDynamicHeight {
            definitionWithDynamicHeight.onHeightChanged = { [weak self, weak tableView, weak definitionWithDynamicHeight] in
                guard let self, let tableView else { return }
                tableView.beginUpdates()
                tableView.endUpdates()
                tableView.fixAnimationMasksToBounds()

                guard let definitionAsExpandable = definitionWithDynamicHeight as? IsExpandable else { return }
                if definitionAsExpandable.isExpanded,
                   definitionAsExpandable.shouldCollapseOthers {
                    collapseElements(otherThan: definitionAsExpandable)
                }
            }
        }

        return cell
    }
}

extension ContentDataSourceImpl {
    private func collapseElements<T: IsExpandable>(otherThan exceptItem: T) {
        let items = sections.flatMap { $0 }.compactMap { $0 as? T }
        let activeItems = items.filter { item -> Bool in
            guard item !== exceptItem else { return false }
            return item.isExpanded
        }
        activeItems.forEach { $0.setIsExpanded(false) }
    }
}
