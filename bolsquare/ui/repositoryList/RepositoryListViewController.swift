//
//  RepositoryListViewController.swift
//  BolSquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit

final class RepositoryListViewController: ViewControllerImpl, HasAppScreen {

    private let viewModel: RepositoryListViewModel
    private let mainView: TableWithCompactHeaderView
    internal var screen: AppScreen { viewModel.screen }

    // MARK: - Lifecycle

    init(viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
        self.mainView = TableWithCompactHeaderView(withHeaderConfiguration: viewModel.headerConfiguration)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreenInfo()
        setupTableView()
        setupActions()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
}

extension RepositoryListViewController {

    private func setupActions() {
        viewModel.onNeedsReload = { [weak self] in
            guard let self else { return }
            self.mainView.tableView.reloadData()
        }

        viewModel.onStateChanged = { [weak self] state in
            guard let self else { return }

            switch state {
            case .failed:
                self.showErrorAlert(message: L10n.Errors.failedLoadRepositories)
            default: break
            }
        }
    }

    private func setupTableView() {
        viewModel.setup(inTableView: mainView.tableView)
    }
}
