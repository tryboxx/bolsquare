// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import UIKit

struct ContentCells {
    static func register(in tableView: UITableView) {
            EmptyCell.register(in: tableView)
            EmptyCell.register(in: tableView)
            HeaderCell.register(in: tableView)
            HeaderCell.register(in: tableView)
            IndicatorCell.register(in: tableView)
            IndicatorCell.register(in: tableView)
            LabelWithValueCell.register(in: tableView)
            LabelWithValueCell.register(in: tableView)
            TextCell.register(in: tableView)
            TextCell.register(in: tableView)
    }
}

class EmptyCell: GenericContentCell<EmptyDefinition, EmptyView> {}
class HeaderCell: GenericContentCell<HeaderDefinition, HeaderView> {}
class IndicatorCell: GenericContentCell<IndicatorDefinition, IndicatorView> {}
class LabelWithValueCell: GenericContentCell<LabelWithValueDefinition, LabelWithValueView> {}
class TextCell: GenericContentCell<TextDefinition, TextView> {}

extension ContentDataSourceImpl {
    func cell(for item: ContentItemDefinition, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        switch item {
            case let item as EmptyDefinition: return prepare(cellType: EmptyCell.self, definition: item, tableView: tableView, indexPath: indexPath)
            case let item as HeaderDefinition: return prepare(cellType: HeaderCell.self, definition: item, tableView: tableView, indexPath: indexPath)
            case let item as IndicatorDefinition: return prepare(cellType: IndicatorCell.self, definition: item, tableView: tableView, indexPath: indexPath)
            case let item as LabelWithValueDefinition: return prepare(cellType: LabelWithValueCell.self, definition: item, tableView: tableView, indexPath: indexPath)
            case let item as TextDefinition: return prepare(cellType: TextCell.self, definition: item, tableView: tableView, indexPath: indexPath)
            case let item as EmptyDefinition: return prepare(cellType: EmptyCell.self, definition: item, tableView: tableView, indexPath: indexPath)
            case let item as HeaderDefinition: return prepare(cellType: HeaderCell.self, definition: item, tableView: tableView, indexPath: indexPath)
            case let item as IndicatorDefinition: return prepare(cellType: IndicatorCell.self, definition: item, tableView: tableView, indexPath: indexPath)
            case let item as LabelWithValueDefinition: return prepare(cellType: LabelWithValueCell.self, definition: item, tableView: tableView, indexPath: indexPath)
            case let item as TextDefinition: return prepare(cellType: TextCell.self, definition: item, tableView: tableView, indexPath: indexPath)
        default:
        assertionFailure("FATAL ERROR!! Did not found cell for \(String(describing: item)) definition")
        return nil
        }
    }
}
