//
//  RepositoryListViewControllerTests.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation
import XCTest
import Nimble
import Nimble_Snapshots

@testable import bolsquare

class RepositoryListViewControllerTests: BaseTestCase {

    var rootInjector: AppRootInjector!
    var factory: FactoryMock!
    var networkService: NetworkServiceMock!

    override func setUp() {
        rootInjector = createMockRootInjector()
        factory = rootInjector.factory as? FactoryMock
        networkService = rootInjector.networkService as? NetworkServiceMock
    }

    override func tearDown() {
        networkService = nil
        factory = nil
        rootInjector = nil
    }

    func testViewController() async {
        networkService.fetchRepositoriesReturnValue = [SampleRepository.filled.repository, SampleRepository.withoutDescription.repository]

        let VM = prepareVM()
        let VC = prepareVC(withVM: VM)

        await expect(VM.state).toEventually(equal(CommonViewModelState.done))

        prepare(view: VC.view)
        expect(VC.view) != nil
        expect(VC.view) == snapshot()
    }

    func testViewController_whenFetchingRepositories() {
        networkService.fetchRepositoriesReturnValue = []

        let VM = prepareVM()
        let VC = prepareVC(withVM: VM)

        prepare(view: VC.view)
        expect(VC.view) != nil
        expect(VC.view) == snapshot()
    }

    func testViewController_whenNoRepositories() async {
        networkService.fetchRepositoriesReturnValue = []

        let VM = prepareVM()
        let VC = prepareVC(withVM: VM)

        await expect(VM.state).toEventually(equal(CommonViewModelState.done))

        prepare(view: VC.view)
        expect(VC.view) != nil
        expect(VC.view) == snapshot()
    }

    private func prepareVC(withVM VM: RepositoryListViewModelImpl) -> RepositoryListViewController {
        factory.contentDataSourceReturnValue = ContentDataSourceImpl()

        let VC = RepositoryListViewController(viewModel: VM)
        prepare(view: VC.view)

        return VC
    }
}

extension RepositoryListViewControllerTests {

    func prepareVM() -> RepositoryListViewModel {
        factory.contentDataSourceReturnValue = ContentDataSourceImpl()

        let viewModel = RepositoryListViewModelImpl(injector: rootInjector.inject())
        viewModel.loadData()
        return viewModel
    }

    func prepareVC(withVM viewModel: RepositoryListViewModel) -> RepositoryListViewController {
        let VC = RepositoryListViewController(viewModel: viewModel)
        return VC
    }
}
