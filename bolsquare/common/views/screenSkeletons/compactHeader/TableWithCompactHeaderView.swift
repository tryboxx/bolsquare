//
//  TableWithCompactHeaderView.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

class TableWithCompactHeaderView: PageWithCompactHeaderView {

    let tableView = SelfSizedTableView.createDefault()

    private var lastTableViewBounds = CGRect.zero

    override init(
        withHeaderConfiguration configuration: HeaderConfiguration,
        backgroundConfiguration: PageBackgroundConfiguration? = nil,
        viewStyle: AppStyle? = nil
    ) {
        super.init(
            withHeaderConfiguration: configuration,
            backgroundConfiguration: backgroundConfiguration,
            viewStyle: viewStyle
        )

        setupView()
        setupLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setUpTapGesture() {
        tapRecognizer.addTarget(self, action: #selector(viewTapped))
        tapRecognizer.delegate = self
        tableView.addGestureRecognizer(tapRecognizer)
    }

    @objc override func viewTapped() {
        tableView.dismissKeyboard()
    }

    override func updateHeaderTrackingView() {
        guard customHeaderTrackingView == nil else { return }

        let trackingView = findHeaderTrackingView()
        headerView.trackingView = trackingView
    }
}

extension TableWithCompactHeaderView {
    private func setupView() {
        contentView.addSubview(tableView)

        tableView.onDataReloaded = { [weak self] in
            self?.updateHeaderTrackingView()
        }
    }

    private func setupLayouts() {
        tableView.applyLayout(Layouts.tableView)
    }
}

private extension TableWithCompactHeaderView {
    func updateHeaderTrackingViewIfNeeded() {
        if lastTableViewBounds != tableView.bounds {
            lastTableViewBounds = tableView.bounds
            updateHeaderTrackingView()
        }
    }

    func findHeaderTrackingView() -> UIView? {
        guard tableView.numberOfSections > 0 else { return nil }

        let section = 0
        let rows = tableView.numberOfRows(inSection: section)

        for row in 0 ..< rows {
            guard let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) else { return nil }
            let labels = cell.findViews(subclassOf: UILabel.self)
            if let topLabel = labels.findTopView(within: cell) {
                return topLabel
            }
        }

        return nil
    }
}

private extension TableWithCompactHeaderView {
    enum Layouts {
        static let tableView = layoutPinAll
    }
}
