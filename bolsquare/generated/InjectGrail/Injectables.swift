// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import UIKit



// MARK: - MainCoordinatorImpl
// This extension contains `inject` functions of Injectors injected by MainCoordinatorImpl.
// That is InjectsRepositoryListCoordinatorInjector.
// Based on the conforming to InjectsRepositoryListCoordinatorInjector
// and  proxy variables that makes properties of MainCoordinatorInjector visible in MainCoordinatorImpl.
extension MainCoordinatorImpl {
 var factory: Factory { return injector.factory } 
 var routingController: RoutingController { return injector.routingController } 
 var mainScreenContext: MainScreenContext { return injector.mainScreenContext } 
 var networkService: NetworkService { return injector.networkService } 

    func inject() -> RepositoryListCoordinatorInjectorImpl {
      return RepositoryListCoordinatorInjectorImpl(
        factory: injector.factory,
      networkService: injector.networkService
      )
    }
    
     
  }

//Classes that want to inject objects of MainCoordinatorImpl should confom to this protocol. 
//InjectGrail will extend their implementations with `inject` functions creating `MainCoordinatorImplInjector`
protocol InjectsMainCoordinatorInjector {}



// MARK: - MainRouter
// This extension contains `inject` functions of Injectors injected by MainRouter.
// That is InjectsMainCoordinatorInjector.
// Based on the conforming to InjectsMainCoordinatorInjector
// and  proxy variables that makes properties of MainRouterInjector visible in MainRouter.
extension MainRouter {
 var factory: Factory { return injector.factory } 
 var routingController: RoutingController { return injector.routingController } 
 var networkService: NetworkService { return injector.networkService } 

    func inject(mainScreenContext: MainScreenContext) -> MainCoordinatorInjectorImpl {
      return MainCoordinatorInjectorImpl(
        factory: injector.factory,
      routingController: injector.routingController,
      mainScreenContext: mainScreenContext,
      networkService: injector.networkService
      )
    }
    
     
  }

//Classes that want to inject objects of MainRouter should confom to this protocol. 
//InjectGrail will extend their implementations with `inject` functions creating `MainRouterInjector`
protocol InjectsMainRouterInjector {}



// MARK: - RepositoryListCoordinatorImpl
// This extension contains `inject` functions of Injectors injected by RepositoryListCoordinatorImpl.
// That is InjectsRepositoryListViewModelInjector.
// Based on the conforming to InjectsRepositoryListViewModelInjector
// and  proxy variables that makes properties of RepositoryListCoordinatorInjector visible in RepositoryListCoordinatorImpl.
extension RepositoryListCoordinatorImpl {
 var factory: Factory { return injector.factory } 
 var networkService: NetworkService { return injector.networkService } 

    func inject() -> RepositoryListViewModelInjectorImpl {
      return RepositoryListViewModelInjectorImpl(
        factory: injector.factory,
      networkService: injector.networkService
      )
    }
    
     
  }

//Classes that want to inject objects of RepositoryListCoordinatorImpl should confom to this protocol. 
//InjectGrail will extend their implementations with `inject` functions creating `RepositoryListCoordinatorImplInjector`
protocol InjectsRepositoryListCoordinatorInjector {}



// MARK: - RepositoryListViewModelImpl
// This extension contains `inject` functions of Injectors injected by RepositoryListViewModelImpl.
// That is .
// Based on the conforming to 
// and  proxy variables that makes properties of RepositoryListViewModelInjector visible in RepositoryListViewModelImpl.
extension RepositoryListViewModelImpl {
 var factory: Factory { return injector.factory } 
 var networkService: NetworkService { return injector.networkService } 
}

//Classes that want to inject objects of RepositoryListViewModelImpl should confom to this protocol. 
//InjectGrail will extend their implementations with `inject` functions creating `RepositoryListViewModelImplInjector`
protocol InjectsRepositoryListViewModelInjector {}
