//
//  RepositoryListViewModelTests.swift
//  bolsquareTests
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import XCTest
import Nimble

@testable import bolsquare

class RepositoryListViewModelTests: BaseTestCase {

    var rootInjector: AppRootInjector!
    var factory: FactoryMock!
    var networkService: NetworkServiceMock!

    override func setUp() {
        rootInjector = createMockRootInjector()
        factory = rootInjector.factory as? FactoryMock
        networkService = rootInjector.networkService as? NetworkServiceMock
    }

   func testPrepareContent_whenAllDataLoaded() {
       networkService.fetchRepositoriesReturnValue = []

       let dataSource = ContentDataSourceMock()

       let viewModel = makeViewModel(datasource: dataSource)
       viewModel.loadData()

       expect(dataSource.loadItemsCallsCount) == 1
       expect(dataSource.loadItemsReceivedItems?.count) == 7
   }

    func testLoadData_setsStateToBusyThenDone() async {
        networkService.fetchRepositoriesReturnValue = [SampleRepository.filled.repository, SampleRepository.withoutDescription.repository]

        let viewModel = makeViewModel(datasource: ContentDataSourceMock())

        var states: [CommonViewModelState] = []
        viewModel.onStateChanged = { state in
            states.append(state)
        }

        await waitUntil(timeout: .seconds(2)) { done in
            viewModel.onStateChanged = { state in
                states.append(state)
                if state == .done {
                    done()
                }
            }
            viewModel.loadData()
        }

        expect(states.first?.isBusy) == true
        expect(states.last) == .done
    }

    func testLoadData_setsStateToFailedOnError() async {
        networkService.fetchRepositoriesThrowableError = SampleError.unableToPerformThisOperation

        let viewModel = makeViewModel(datasource: ContentDataSourceMock())

        await waitUntil(timeout: .seconds(2)) { done in
            viewModel.onStateChanged = { state in
                switch state {
                case .failed: done()
                default: break
                }
            }
            viewModel.loadData()
        }

        expect(viewModel.state == .failed(nil)) == true
    }

    func testPrepareContent_callsNeedsReload() {
        networkService.fetchRepositoriesReturnValue = []

        let viewModel = makeViewModel(datasource: ContentDataSourceMock())
        viewModel.loadData()

        var reloadCalled = false
        viewModel.onNeedsReload = {
            reloadCalled = true
        }

        viewModel.loadData()

        expect(reloadCalled).toEventually(beTrue(), timeout: .seconds(2))
    }

    func testLoadData_populatesContentItemsCorrectly() async {
        networkService.fetchRepositoriesReturnValue = [SampleRepository.filled.repository]

        let dataSource = ContentDataSourceMock()
        let viewModel = makeViewModel(datasource: dataSource)

        await waitUntil(timeout: .seconds(2)) { done in
            viewModel.onStateChanged = { state in
                if state == .done {
                    done()
                }
            }
            viewModel.loadData()
        }

        let items = dataSource.loadItemsReceivedItems ?? []
        expect(items).toNot(beEmpty())

        let hasLabel = items.contains { $0 is LabelWithValueDefinition }
        expect(hasLabel) == true
    }
}

extension RepositoryListViewModelTests {

    private func makeViewModel(datasource: ContentDataSourceMock) -> RepositoryListViewModelImpl {
        factory.contentDataSourceReturnValue = datasource

        return RepositoryListViewModelImpl(injector: rootInjector.inject())
    }
}
