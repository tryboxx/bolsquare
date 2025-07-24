//
//  RootInjector.swift
//  bolsquareTests
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

@testable import bolsquare

@MainActor
func createMockRootInjector(
    factory: Factory? = nil,
    networkService: NetworkService? = nil,
    routingController: RoutingController? = nil
) -> AppRootInjector {
    AppRootInjector(
        factory: factory ?? FactoryMock(),
        networkService: networkService ?? NetworkServiceMock(),
        routingController: routingController ?? RoutingControllerMock()
    )
}

@MainActor
func createRootInjector(
    factory: Factory? = nil,
    networkService: NetworkService? = nil,
    routingController: RoutingController? = nil
) -> AppRootInjector {
    let factory = factory ?? FactoryImpl()
    let networkService = networkService ?? NetworkServiceImpl()
    let routingController = RoutingControllerImpl()

    return AppRootInjector(
        factory: factory,
        networkService: networkService,
        routingController: routingController
    )
}
