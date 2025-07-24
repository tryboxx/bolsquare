//
//  AppDelegate.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit
import InjectGrail
import InjectGrailMacros

struct AppRootInjector: RootInjector {
    let factory: Factory
    let networkService: NetworkService
    let routingController: RoutingController
}

@Injects<
    MainRouter
>
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootInjector: RootInjector?
    private var router: MainRouter?
    private var routingController: RoutingControllerImpl?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppUI.initialize(with: AppUIDependencies())
        UIView.appearance().isExclusiveTouch = true
        UINavigationBar.appearance().tintColor = Colors.black.color
        UISwitch.appearance().onTintColor = Colors.orange600.color

        window = UIWindow(frame: UIScreen.main.bounds)

        // Services
        let factory = FactoryImpl()
        let networkService = NetworkServiceImpl()

        let routingController = RoutingControllerImpl()
        self.routingController = routingController

        let rootInjector = AppRootInjector(
            factory: factory,
            networkService: networkService,
            routingController: routingController
        )

        self.rootInjector = rootInjector
        let router = MainRouter(injector: rootInjector.inject())
        self.router = router
        self.routingController?.mainRouter = router

        window?.rootViewController = router.routingViewController
        window?.makeKeyAndVisible()
        router.start()

        return true
    }
}
