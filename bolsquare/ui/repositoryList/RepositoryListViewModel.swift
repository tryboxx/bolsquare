//
//  RepositoryListViewModel.swift
//  BolSquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit
import InjectGrail
import InjectGrailMacros

protocol RepositoryListViewModel: ViewModel, AutoMockable, HasAppScreen, HasHeader {
    var state: CommonViewModelState { get }

    var onNeedsReload: (() -> Void)? { get set }
    var onStateChanged: ((CommonViewModelState) -> Void)? { get set }

    func setup(inTableView tableView: UITableView)
    func viewDidAppear()
}

protocol RepositoryListViewModelInjector {
    var factory: Factory { get }
    var networkService: NetworkService { get }
}

@NeedsInjector
final class RepositoryListViewModelImpl: ViewModelImpl, RepositoryListViewModel {

    let screen: AppScreen

    let dataSource: ContentDataSource

    var onNeedsReload: (() -> Void)?
    var onStateChanged: ((CommonViewModelState) -> Void)?

    var state: CommonViewModelState = .idle {
        didSet {
            onStateChanged?(state)
        }
    }

    private var repositories: [Repository] = []

    init(injector: RepositoryListViewModelInjectorImpl) {
        self.injector = injector
        self.screen = .repositoryList
        self.dataSource = injector.factory.contentDataSource()

        super.init()
    }

    func setup(inTableView tableView: UITableView) {
        dataSource.setup(inTableView: tableView)
    }

    func viewDidAppear() {
        /// In real scenario, could be also performed after `super.init`
        loadData()
    }

    override func prepareHeaderConfiguration() -> HeaderConfiguration {
        HeaderConfiguration(
            type: .compact,
            title: ""
        )
    }
}

// MARK: - Public interface
internal extension RepositoryListViewModelImpl {

    func loadData() {
        state = .busy()
        prepareContent()

        Task {
            do {
                let repositories = try await networkService.fetchRepositories()
                await MainActor.run { [weak self] in
                    self?.state = .done
                    self?.repositories = repositories
                    self?.prepareContent()
                }
            } catch {
                state = .failed()
                prepareContent()
            }
        }
    }
}

// MARK: - Content builder
private extension RepositoryListViewModelImpl {

    private func prepareContent() {
        var items = [ContentItemDefinition]()
        items.append(contentsOf: prepareHeaderSection())

        if state == .busy() {
            items.append(EmptyDefinition(withHeight: 40))
            items.append(contentsOf: prepareLoadingSection())
        } else if repositories.isEmpty == false {
            items.append(contentsOf: prepareRepositoryListSection().withSpacers(height: 8))
        } else {
            items.append(EmptyDefinition(withHeight: 16))
            items.append(
                TextDefinition(
                    text: L10n.RepositoryList.EmptyState.title,
                    textAlignment: .center,
                    style: AppStyle.label,
                    insets: UIEdgeInsets(horizontal: 64)
                )
            )
        }

        items.append(EmptyDefinition(withHeight: 80))

        dataSource.load(items: items)
        onNeedsReload?()
    }

    private func prepareHeaderSection() -> [ContentItemDefinition] {
        var items = [ContentItemDefinition]()
        items.append(HeaderDefinition(title: L10n.RepositoryList.Header.title, style: .large))
        items.append(EmptyDefinition(withHeight: 4))
        items.append(
            TextDefinition(
                text: L10n.RepositoryList.Header.subtitle(String(repositories.count)),
                viewStyle: CompoundStyle(
                    textStyle: AppStyle.subtitle2.textStyle,
                    colorStyle: ColorStyle(textColor: Colors.neutral900.color)
                )
            )
        )
        items.append(EmptyDefinition(withHeight: 40))

        return items
    }

    private func prepareLoadingSection() -> [ContentItemDefinition] {
        var items = [ContentItemDefinition]()
        items.append(IndicatorDefinition())
        return items
    }

    private func prepareRepositoryListSection() -> [ContentItemDefinition] {
        repositories.compactMap {
            LabelWithValueDefinition(name: $0.name, value: $0.description ?? L10n.RepositoryList.Owner.name($0.owner?.login ?? ""))
        }
    }
}
