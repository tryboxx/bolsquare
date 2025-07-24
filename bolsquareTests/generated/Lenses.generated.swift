// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable all

import Foundation
import UIKit
@testable import bolsquare

infix operator *~: MultiplicationPrecedence
infix operator |>: AdditionPrecedence

struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}

func * <A, B, C> (lhs: Lens<A, B>, rhs: Lens<B, C>) -> Lens<A, C> {
    return Lens<A, C>(
        get: { a in rhs.get(lhs.get(a)) },
        set: { (c, a) in lhs.set(rhs.set(c, lhs.get(a)), a) }
    )
}

func *~ <A, B> (lhs: Lens<A, B>, rhs: B) -> (A) -> A {
    return { a in lhs.set(rhs, a) }
}

func |> <A, B> (x: A, f: (A) -> B) -> B {
    return f(x)
}

func |> <A, B, C> (f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}


extension ContentDataSourceCellProviderMock {
  func with(dataSourceCustomCellForItemTableViewIndexPathCallsCount: Int) -> ContentDataSourceCellProviderMock {
    self.dataSourceCustomCellForItemTableViewIndexPathCallsCount = dataSourceCustomCellForItemTableViewIndexPathCallsCount
    return self
  }
  func with(dataSourceCustomCellForItemTableViewIndexPathReceivedArguments: (item: ContentItemDefinition, tableView: UITableView, indexPath: IndexPath)?) -> ContentDataSourceCellProviderMock {
    self.dataSourceCustomCellForItemTableViewIndexPathReceivedArguments = dataSourceCustomCellForItemTableViewIndexPathReceivedArguments
    return self
  }
  func with(dataSourceCustomCellForItemTableViewIndexPathReceivedInvocations: [(item: ContentItemDefinition, tableView: UITableView, indexPath: IndexPath)]) -> ContentDataSourceCellProviderMock {
    self.dataSourceCustomCellForItemTableViewIndexPathReceivedInvocations = dataSourceCustomCellForItemTableViewIndexPathReceivedInvocations
    return self
  }
  func with(dataSourceCustomCellForItemTableViewIndexPathReturnValue: UITableViewCell?) -> ContentDataSourceCellProviderMock {
    self.dataSourceCustomCellForItemTableViewIndexPathReturnValue = dataSourceCustomCellForItemTableViewIndexPathReturnValue
    return self
  }
  func with(dataSourceCustomCellForItemTableViewIndexPathClosure: ((ContentItemDefinition, UITableView, IndexPath) -> UITableViewCell?)?) -> ContentDataSourceCellProviderMock {
    self.dataSourceCustomCellForItemTableViewIndexPathClosure = dataSourceCustomCellForItemTableViewIndexPathClosure
    return self
  }
}
extension ContentDataSourceMock {
  func with(cellProvider: ContentDataSourceCellProvider?) -> ContentDataSourceMock {
    self.cellProvider = cellProvider
    return self
  }
  func with(underlyingCellContentInsets: ContentInsets!) -> ContentDataSourceMock {
    self.underlyingCellContentInsets = underlyingCellContentInsets
    return self
  }
  func with(setupInTableViewCallsCount: Int) -> ContentDataSourceMock {
    self.setupInTableViewCallsCount = setupInTableViewCallsCount
    return self
  }
  func with(setupInTableViewReceivedTableView: UITableView?) -> ContentDataSourceMock {
    self.setupInTableViewReceivedTableView = setupInTableViewReceivedTableView
    return self
  }
  func with(setupInTableViewReceivedInvocations: [UITableView]) -> ContentDataSourceMock {
    self.setupInTableViewReceivedInvocations = setupInTableViewReceivedInvocations
    return self
  }
  func with(setupInTableViewClosure: ((UITableView) -> Void)?) -> ContentDataSourceMock {
    self.setupInTableViewClosure = setupInTableViewClosure
    return self
  }
  func with(loadSectionsCallsCount: Int) -> ContentDataSourceMock {
    self.loadSectionsCallsCount = loadSectionsCallsCount
    return self
  }
  func with(loadSectionsReceivedSections: [[ContentItemDefinition]]?) -> ContentDataSourceMock {
    self.loadSectionsReceivedSections = loadSectionsReceivedSections
    return self
  }
  func with(loadSectionsReceivedInvocations: [[[ContentItemDefinition]]]) -> ContentDataSourceMock {
    self.loadSectionsReceivedInvocations = loadSectionsReceivedInvocations
    return self
  }
  func with(loadSectionsClosure: (([[ContentItemDefinition]]) -> Void)?) -> ContentDataSourceMock {
    self.loadSectionsClosure = loadSectionsClosure
    return self
  }
  func with(loadItemsCallsCount: Int) -> ContentDataSourceMock {
    self.loadItemsCallsCount = loadItemsCallsCount
    return self
  }
  func with(loadItemsReceivedItems: [ContentItemDefinition]?) -> ContentDataSourceMock {
    self.loadItemsReceivedItems = loadItemsReceivedItems
    return self
  }
  func with(loadItemsReceivedInvocations: [[ContentItemDefinition]]) -> ContentDataSourceMock {
    self.loadItemsReceivedInvocations = loadItemsReceivedInvocations
    return self
  }
  func with(loadItemsClosure: (([ContentItemDefinition]) -> Void)?) -> ContentDataSourceMock {
    self.loadItemsClosure = loadItemsClosure
    return self
  }
  func with(loadSectionItemsSectionCallsCount: Int) -> ContentDataSourceMock {
    self.loadSectionItemsSectionCallsCount = loadSectionItemsSectionCallsCount
    return self
  }
  func with(loadSectionItemsSectionReceivedArguments: (sectionItems: [ContentItemDefinition], section: Int)?) -> ContentDataSourceMock {
    self.loadSectionItemsSectionReceivedArguments = loadSectionItemsSectionReceivedArguments
    return self
  }
  func with(loadSectionItemsSectionReceivedInvocations: [(sectionItems: [ContentItemDefinition], section: Int)]) -> ContentDataSourceMock {
    self.loadSectionItemsSectionReceivedInvocations = loadSectionItemsSectionReceivedInvocations
    return self
  }
  func with(loadSectionItemsSectionClosure: (([ContentItemDefinition], Int) -> Void)?) -> ContentDataSourceMock {
    self.loadSectionItemsSectionClosure = loadSectionItemsSectionClosure
    return self
  }
}
extension CoordinatorMock {
  func with(underlyingViewController: ViewController!) -> CoordinatorMock {
    self.underlyingViewController = underlyingViewController
    return self
  }
  func with(navigationController: NavigationController?) -> CoordinatorMock {
    self.navigationController = navigationController
    return self
  }
  func with(rootViewController: UIViewController?) -> CoordinatorMock {
    self.rootViewController = rootViewController
    return self
  }
  func with(haveAnyChildrenCallsCount: Int) -> CoordinatorMock {
    self.haveAnyChildrenCallsCount = haveAnyChildrenCallsCount
    return self
  }
  func with(haveAnyChildrenReturnValue: Bool!) -> CoordinatorMock {
    self.haveAnyChildrenReturnValue = haveAnyChildrenReturnValue
    return self
  }
  func with(haveAnyChildrenClosure: (() -> Bool)?) -> CoordinatorMock {
    self.haveAnyChildrenClosure = haveAnyChildrenClosure
    return self
  }
  func with(addChildCallsCount: Int) -> CoordinatorMock {
    self.addChildCallsCount = addChildCallsCount
    return self
  }
  func with(addChildReceivedCoordinator: Coordinator?) -> CoordinatorMock {
    self.addChildReceivedCoordinator = addChildReceivedCoordinator
    return self
  }
  func with(addChildReceivedInvocations: [Coordinator]) -> CoordinatorMock {
    self.addChildReceivedInvocations = addChildReceivedInvocations
    return self
  }
  func with(addChildClosure: ((Coordinator) -> Void)?) -> CoordinatorMock {
    self.addChildClosure = addChildClosure
    return self
  }
  func with(childDidFinishCallsCount: Int) -> CoordinatorMock {
    self.childDidFinishCallsCount = childDidFinishCallsCount
    return self
  }
  func with(childDidFinishReceivedCoordinator: Coordinator?) -> CoordinatorMock {
    self.childDidFinishReceivedCoordinator = childDidFinishReceivedCoordinator
    return self
  }
  func with(childDidFinishReceivedInvocations: [Coordinator]) -> CoordinatorMock {
    self.childDidFinishReceivedInvocations = childDidFinishReceivedInvocations
    return self
  }
  func with(childDidFinishClosure: ((Coordinator) -> Void)?) -> CoordinatorMock {
    self.childDidFinishClosure = childDidFinishClosure
    return self
  }
  func with(setNavigationControllerCallsCount: Int) -> CoordinatorMock {
    self.setNavigationControllerCallsCount = setNavigationControllerCallsCount
    return self
  }
  func with(setNavigationControllerReceivedNavigationController: NavigationController?) -> CoordinatorMock {
    self.setNavigationControllerReceivedNavigationController = setNavigationControllerReceivedNavigationController
    return self
  }
  func with(setNavigationControllerReceivedInvocations: [NavigationController?]) -> CoordinatorMock {
    self.setNavigationControllerReceivedInvocations = setNavigationControllerReceivedInvocations
    return self
  }
  func with(setNavigationControllerClosure: ((NavigationController?) -> Void)?) -> CoordinatorMock {
    self.setNavigationControllerClosure = setNavigationControllerClosure
    return self
  }
  func with(startFromActionCallsCount: Int) -> CoordinatorMock {
    self.startFromActionCallsCount = startFromActionCallsCount
    return self
  }
  func with(startFromActionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction)?) -> CoordinatorMock {
    self.startFromActionReceivedArguments = startFromActionReceivedArguments
    return self
  }
  func with(startFromActionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction)]) -> CoordinatorMock {
    self.startFromActionReceivedInvocations = startFromActionReceivedInvocations
    return self
  }
  func with(startFromActionClosure: ((Coordinator, CoordinatorAction) -> Void)?) -> CoordinatorMock {
    self.startFromActionClosure = startFromActionClosure
    return self
  }
  func with(startFromActionCompletionCallsCount: Int) -> CoordinatorMock {
    self.startFromActionCompletionCallsCount = startFromActionCompletionCallsCount
    return self
  }
  func with(startFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?) -> CoordinatorMock {
    self.startFromActionCompletionReceivedArguments = startFromActionCompletionReceivedArguments
    return self
  }
  func with(startFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)]) -> CoordinatorMock {
    self.startFromActionCompletionReceivedInvocations = startFromActionCompletionReceivedInvocations
    return self
  }
  func with(startFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?) -> CoordinatorMock {
    self.startFromActionCompletionClosure = startFromActionCompletionClosure
    return self
  }
  func with(addToParentCoordinatorCallsCount: Int) -> CoordinatorMock {
    self.addToParentCoordinatorCallsCount = addToParentCoordinatorCallsCount
    return self
  }
  func with(addToParentCoordinatorReceivedParentCoordinator: Coordinator?) -> CoordinatorMock {
    self.addToParentCoordinatorReceivedParentCoordinator = addToParentCoordinatorReceivedParentCoordinator
    return self
  }
  func with(addToParentCoordinatorReceivedInvocations: [Coordinator]) -> CoordinatorMock {
    self.addToParentCoordinatorReceivedInvocations = addToParentCoordinatorReceivedInvocations
    return self
  }
  func with(addToParentCoordinatorClosure: ((Coordinator) -> Void)?) -> CoordinatorMock {
    self.addToParentCoordinatorClosure = addToParentCoordinatorClosure
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionCallsCount: Int) -> CoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionCallsCount = addToViewControllersHierarchyFromActionCompletionCallsCount
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?) -> CoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionReceivedArguments = addToViewControllersHierarchyFromActionCompletionReceivedArguments
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)]) -> CoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionReceivedInvocations = addToViewControllersHierarchyFromActionCompletionReceivedInvocations
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?) -> CoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionClosure = addToViewControllersHierarchyFromActionCompletionClosure
    return self
  }
  func with(closeAnimatedCompletionCallsCount: Int) -> CoordinatorMock {
    self.closeAnimatedCompletionCallsCount = closeAnimatedCompletionCallsCount
    return self
  }
  func with(closeAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> CoordinatorMock {
    self.closeAnimatedCompletionReceivedArguments = closeAnimatedCompletionReceivedArguments
    return self
  }
  func with(closeAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> CoordinatorMock {
    self.closeAnimatedCompletionReceivedInvocations = closeAnimatedCompletionReceivedInvocations
    return self
  }
  func with(closeAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> CoordinatorMock {
    self.closeAnimatedCompletionClosure = closeAnimatedCompletionClosure
    return self
  }
  func with(closeAndFinishAnimatedCompletionCallsCount: Int) -> CoordinatorMock {
    self.closeAndFinishAnimatedCompletionCallsCount = closeAndFinishAnimatedCompletionCallsCount
    return self
  }
  func with(closeAndFinishAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> CoordinatorMock {
    self.closeAndFinishAnimatedCompletionReceivedArguments = closeAndFinishAnimatedCompletionReceivedArguments
    return self
  }
  func with(closeAndFinishAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> CoordinatorMock {
    self.closeAndFinishAnimatedCompletionReceivedInvocations = closeAndFinishAnimatedCompletionReceivedInvocations
    return self
  }
  func with(closeAndFinishAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> CoordinatorMock {
    self.closeAndFinishAnimatedCompletionClosure = closeAndFinishAnimatedCompletionClosure
    return self
  }
  func with(removeFromParentCallsCount: Int) -> CoordinatorMock {
    self.removeFromParentCallsCount = removeFromParentCallsCount
    return self
  }
  func with(removeFromParentClosure: (() -> Void)?) -> CoordinatorMock {
    self.removeFromParentClosure = removeFromParentClosure
    return self
  }
  func with(popToSelfAnimatedCompletionCallsCount: Int) -> CoordinatorMock {
    self.popToSelfAnimatedCompletionCallsCount = popToSelfAnimatedCompletionCallsCount
    return self
  }
  func with(popToSelfAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> CoordinatorMock {
    self.popToSelfAnimatedCompletionReceivedArguments = popToSelfAnimatedCompletionReceivedArguments
    return self
  }
  func with(popToSelfAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> CoordinatorMock {
    self.popToSelfAnimatedCompletionReceivedInvocations = popToSelfAnimatedCompletionReceivedInvocations
    return self
  }
  func with(popToSelfAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> CoordinatorMock {
    self.popToSelfAnimatedCompletionClosure = popToSelfAnimatedCompletionClosure
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionCallsCount: Int) -> CoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionCallsCount = dismissRootModalCoordinatorAnimatedCompletionCallsCount
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> CoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionReceivedArguments = dismissRootModalCoordinatorAnimatedCompletionReceivedArguments
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> CoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations = dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> CoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionClosure = dismissRootModalCoordinatorAnimatedCompletionClosure
    return self
  }
}
extension FactoryMock {
  func with(contentDataSourceCallsCount: Int) -> FactoryMock {
    self.contentDataSourceCallsCount = contentDataSourceCallsCount
    return self
  }
  func with(contentDataSourceReturnValue: ContentDataSource!) -> FactoryMock {
    self.contentDataSourceReturnValue = contentDataSourceReturnValue
    return self
  }
  func with(contentDataSourceClosure: (() -> ContentDataSource)?) -> FactoryMock {
    self.contentDataSourceClosure = contentDataSourceClosure
    return self
  }
  func with(mainCoordinatorInjectorCallsCount: Int) -> FactoryMock {
    self.mainCoordinatorInjectorCallsCount = mainCoordinatorInjectorCallsCount
    return self
  }
  func with(mainCoordinatorInjectorReceivedInjector: MainCoordinatorInjectorImpl?) -> FactoryMock {
    self.mainCoordinatorInjectorReceivedInjector = mainCoordinatorInjectorReceivedInjector
    return self
  }
  func with(mainCoordinatorInjectorReceivedInvocations: [MainCoordinatorInjectorImpl]) -> FactoryMock {
    self.mainCoordinatorInjectorReceivedInvocations = mainCoordinatorInjectorReceivedInvocations
    return self
  }
  func with(mainCoordinatorInjectorReturnValue: MainCoordinator!) -> FactoryMock {
    self.mainCoordinatorInjectorReturnValue = mainCoordinatorInjectorReturnValue
    return self
  }
  func with(mainCoordinatorInjectorClosure: ((MainCoordinatorInjectorImpl) -> MainCoordinator)?) -> FactoryMock {
    self.mainCoordinatorInjectorClosure = mainCoordinatorInjectorClosure
    return self
  }
  func with(mainRoutingViewControllerCallsCount: Int) -> FactoryMock {
    self.mainRoutingViewControllerCallsCount = mainRoutingViewControllerCallsCount
    return self
  }
  func with(mainRoutingViewControllerReturnValue: MainRoutingViewController!) -> FactoryMock {
    self.mainRoutingViewControllerReturnValue = mainRoutingViewControllerReturnValue
    return self
  }
  func with(mainRoutingViewControllerClosure: (() -> MainRoutingViewController)?) -> FactoryMock {
    self.mainRoutingViewControllerClosure = mainRoutingViewControllerClosure
    return self
  }
  func with(repositoryListCoordinatorInjectorCallsCount: Int) -> FactoryMock {
    self.repositoryListCoordinatorInjectorCallsCount = repositoryListCoordinatorInjectorCallsCount
    return self
  }
  func with(repositoryListCoordinatorInjectorReceivedInjector: RepositoryListCoordinatorInjectorImpl?) -> FactoryMock {
    self.repositoryListCoordinatorInjectorReceivedInjector = repositoryListCoordinatorInjectorReceivedInjector
    return self
  }
  func with(repositoryListCoordinatorInjectorReceivedInvocations: [RepositoryListCoordinatorInjectorImpl]) -> FactoryMock {
    self.repositoryListCoordinatorInjectorReceivedInvocations = repositoryListCoordinatorInjectorReceivedInvocations
    return self
  }
  func with(repositoryListCoordinatorInjectorReturnValue: RepositoryListCoordinator!) -> FactoryMock {
    self.repositoryListCoordinatorInjectorReturnValue = repositoryListCoordinatorInjectorReturnValue
    return self
  }
  func with(repositoryListCoordinatorInjectorClosure: ((RepositoryListCoordinatorInjectorImpl) -> RepositoryListCoordinator)?) -> FactoryMock {
    self.repositoryListCoordinatorInjectorClosure = repositoryListCoordinatorInjectorClosure
    return self
  }
  func with(repositoryListViewModelInjectorCallsCount: Int) -> FactoryMock {
    self.repositoryListViewModelInjectorCallsCount = repositoryListViewModelInjectorCallsCount
    return self
  }
  func with(repositoryListViewModelInjectorReceivedInjector: RepositoryListViewModelInjectorImpl?) -> FactoryMock {
    self.repositoryListViewModelInjectorReceivedInjector = repositoryListViewModelInjectorReceivedInjector
    return self
  }
  func with(repositoryListViewModelInjectorReceivedInvocations: [RepositoryListViewModelInjectorImpl]) -> FactoryMock {
    self.repositoryListViewModelInjectorReceivedInvocations = repositoryListViewModelInjectorReceivedInvocations
    return self
  }
  func with(repositoryListViewModelInjectorReturnValue: RepositoryListViewModel!) -> FactoryMock {
    self.repositoryListViewModelInjectorReturnValue = repositoryListViewModelInjectorReturnValue
    return self
  }
  func with(repositoryListViewModelInjectorClosure: ((RepositoryListViewModelInjectorImpl) -> RepositoryListViewModel)?) -> FactoryMock {
    self.repositoryListViewModelInjectorClosure = repositoryListViewModelInjectorClosure
    return self
  }
  func with(routeBuilderCallsCount: Int) -> FactoryMock {
    self.routeBuilderCallsCount = routeBuilderCallsCount
    return self
  }
  func with(routeBuilderReturnValue: RouteBuilder!) -> FactoryMock {
    self.routeBuilderReturnValue = routeBuilderReturnValue
    return self
  }
  func with(routeBuilderClosure: (() -> RouteBuilder)?) -> FactoryMock {
    self.routeBuilderClosure = routeBuilderClosure
    return self
  }
}
extension MainCoordinatorMock {
  func with(underlyingViewController: ViewController!) -> MainCoordinatorMock {
    self.underlyingViewController = underlyingViewController
    return self
  }
  func with(navigationController: NavigationController?) -> MainCoordinatorMock {
    self.navigationController = navigationController
    return self
  }
  func with(rootViewController: UIViewController?) -> MainCoordinatorMock {
    self.rootViewController = rootViewController
    return self
  }
  func with(haveAnyChildrenCallsCount: Int) -> MainCoordinatorMock {
    self.haveAnyChildrenCallsCount = haveAnyChildrenCallsCount
    return self
  }
  func with(haveAnyChildrenReturnValue: Bool!) -> MainCoordinatorMock {
    self.haveAnyChildrenReturnValue = haveAnyChildrenReturnValue
    return self
  }
  func with(haveAnyChildrenClosure: (() -> Bool)?) -> MainCoordinatorMock {
    self.haveAnyChildrenClosure = haveAnyChildrenClosure
    return self
  }
  func with(addChildCallsCount: Int) -> MainCoordinatorMock {
    self.addChildCallsCount = addChildCallsCount
    return self
  }
  func with(addChildReceivedCoordinator: Coordinator?) -> MainCoordinatorMock {
    self.addChildReceivedCoordinator = addChildReceivedCoordinator
    return self
  }
  func with(addChildReceivedInvocations: [Coordinator]) -> MainCoordinatorMock {
    self.addChildReceivedInvocations = addChildReceivedInvocations
    return self
  }
  func with(addChildClosure: ((Coordinator) -> Void)?) -> MainCoordinatorMock {
    self.addChildClosure = addChildClosure
    return self
  }
  func with(childDidFinishCallsCount: Int) -> MainCoordinatorMock {
    self.childDidFinishCallsCount = childDidFinishCallsCount
    return self
  }
  func with(childDidFinishReceivedCoordinator: Coordinator?) -> MainCoordinatorMock {
    self.childDidFinishReceivedCoordinator = childDidFinishReceivedCoordinator
    return self
  }
  func with(childDidFinishReceivedInvocations: [Coordinator]) -> MainCoordinatorMock {
    self.childDidFinishReceivedInvocations = childDidFinishReceivedInvocations
    return self
  }
  func with(childDidFinishClosure: ((Coordinator) -> Void)?) -> MainCoordinatorMock {
    self.childDidFinishClosure = childDidFinishClosure
    return self
  }
  func with(setNavigationControllerCallsCount: Int) -> MainCoordinatorMock {
    self.setNavigationControllerCallsCount = setNavigationControllerCallsCount
    return self
  }
  func with(setNavigationControllerReceivedNavigationController: NavigationController?) -> MainCoordinatorMock {
    self.setNavigationControllerReceivedNavigationController = setNavigationControllerReceivedNavigationController
    return self
  }
  func with(setNavigationControllerReceivedInvocations: [NavigationController?]) -> MainCoordinatorMock {
    self.setNavigationControllerReceivedInvocations = setNavigationControllerReceivedInvocations
    return self
  }
  func with(setNavigationControllerClosure: ((NavigationController?) -> Void)?) -> MainCoordinatorMock {
    self.setNavigationControllerClosure = setNavigationControllerClosure
    return self
  }
  func with(startFromActionCallsCount: Int) -> MainCoordinatorMock {
    self.startFromActionCallsCount = startFromActionCallsCount
    return self
  }
  func with(startFromActionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction)?) -> MainCoordinatorMock {
    self.startFromActionReceivedArguments = startFromActionReceivedArguments
    return self
  }
  func with(startFromActionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction)]) -> MainCoordinatorMock {
    self.startFromActionReceivedInvocations = startFromActionReceivedInvocations
    return self
  }
  func with(startFromActionClosure: ((Coordinator, CoordinatorAction) -> Void)?) -> MainCoordinatorMock {
    self.startFromActionClosure = startFromActionClosure
    return self
  }
  func with(startFromActionCompletionCallsCount: Int) -> MainCoordinatorMock {
    self.startFromActionCompletionCallsCount = startFromActionCompletionCallsCount
    return self
  }
  func with(startFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?) -> MainCoordinatorMock {
    self.startFromActionCompletionReceivedArguments = startFromActionCompletionReceivedArguments
    return self
  }
  func with(startFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)]) -> MainCoordinatorMock {
    self.startFromActionCompletionReceivedInvocations = startFromActionCompletionReceivedInvocations
    return self
  }
  func with(startFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?) -> MainCoordinatorMock {
    self.startFromActionCompletionClosure = startFromActionCompletionClosure
    return self
  }
  func with(addToParentCoordinatorCallsCount: Int) -> MainCoordinatorMock {
    self.addToParentCoordinatorCallsCount = addToParentCoordinatorCallsCount
    return self
  }
  func with(addToParentCoordinatorReceivedParentCoordinator: Coordinator?) -> MainCoordinatorMock {
    self.addToParentCoordinatorReceivedParentCoordinator = addToParentCoordinatorReceivedParentCoordinator
    return self
  }
  func with(addToParentCoordinatorReceivedInvocations: [Coordinator]) -> MainCoordinatorMock {
    self.addToParentCoordinatorReceivedInvocations = addToParentCoordinatorReceivedInvocations
    return self
  }
  func with(addToParentCoordinatorClosure: ((Coordinator) -> Void)?) -> MainCoordinatorMock {
    self.addToParentCoordinatorClosure = addToParentCoordinatorClosure
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionCallsCount: Int) -> MainCoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionCallsCount = addToViewControllersHierarchyFromActionCompletionCallsCount
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?) -> MainCoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionReceivedArguments = addToViewControllersHierarchyFromActionCompletionReceivedArguments
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)]) -> MainCoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionReceivedInvocations = addToViewControllersHierarchyFromActionCompletionReceivedInvocations
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?) -> MainCoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionClosure = addToViewControllersHierarchyFromActionCompletionClosure
    return self
  }
  func with(closeAnimatedCompletionCallsCount: Int) -> MainCoordinatorMock {
    self.closeAnimatedCompletionCallsCount = closeAnimatedCompletionCallsCount
    return self
  }
  func with(closeAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> MainCoordinatorMock {
    self.closeAnimatedCompletionReceivedArguments = closeAnimatedCompletionReceivedArguments
    return self
  }
  func with(closeAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> MainCoordinatorMock {
    self.closeAnimatedCompletionReceivedInvocations = closeAnimatedCompletionReceivedInvocations
    return self
  }
  func with(closeAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> MainCoordinatorMock {
    self.closeAnimatedCompletionClosure = closeAnimatedCompletionClosure
    return self
  }
  func with(closeAndFinishAnimatedCompletionCallsCount: Int) -> MainCoordinatorMock {
    self.closeAndFinishAnimatedCompletionCallsCount = closeAndFinishAnimatedCompletionCallsCount
    return self
  }
  func with(closeAndFinishAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> MainCoordinatorMock {
    self.closeAndFinishAnimatedCompletionReceivedArguments = closeAndFinishAnimatedCompletionReceivedArguments
    return self
  }
  func with(closeAndFinishAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> MainCoordinatorMock {
    self.closeAndFinishAnimatedCompletionReceivedInvocations = closeAndFinishAnimatedCompletionReceivedInvocations
    return self
  }
  func with(closeAndFinishAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> MainCoordinatorMock {
    self.closeAndFinishAnimatedCompletionClosure = closeAndFinishAnimatedCompletionClosure
    return self
  }
  func with(removeFromParentCallsCount: Int) -> MainCoordinatorMock {
    self.removeFromParentCallsCount = removeFromParentCallsCount
    return self
  }
  func with(removeFromParentClosure: (() -> Void)?) -> MainCoordinatorMock {
    self.removeFromParentClosure = removeFromParentClosure
    return self
  }
  func with(popToSelfAnimatedCompletionCallsCount: Int) -> MainCoordinatorMock {
    self.popToSelfAnimatedCompletionCallsCount = popToSelfAnimatedCompletionCallsCount
    return self
  }
  func with(popToSelfAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> MainCoordinatorMock {
    self.popToSelfAnimatedCompletionReceivedArguments = popToSelfAnimatedCompletionReceivedArguments
    return self
  }
  func with(popToSelfAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> MainCoordinatorMock {
    self.popToSelfAnimatedCompletionReceivedInvocations = popToSelfAnimatedCompletionReceivedInvocations
    return self
  }
  func with(popToSelfAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> MainCoordinatorMock {
    self.popToSelfAnimatedCompletionClosure = popToSelfAnimatedCompletionClosure
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionCallsCount: Int) -> MainCoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionCallsCount = dismissRootModalCoordinatorAnimatedCompletionCallsCount
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> MainCoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionReceivedArguments = dismissRootModalCoordinatorAnimatedCompletionReceivedArguments
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> MainCoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations = dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> MainCoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionClosure = dismissRootModalCoordinatorAnimatedCompletionClosure
    return self
  }
  func with(isReadyToHandleRoutesCallsCount: Int) -> MainCoordinatorMock {
    self.isReadyToHandleRoutesCallsCount = isReadyToHandleRoutesCallsCount
    return self
  }
  func with(isReadyToHandleRoutesReturnValue: Bool!) -> MainCoordinatorMock {
    self.isReadyToHandleRoutesReturnValue = isReadyToHandleRoutesReturnValue
    return self
  }
  func with(isReadyToHandleRoutesClosure: (() -> Bool)?) -> MainCoordinatorMock {
    self.isReadyToHandleRoutesClosure = isReadyToHandleRoutesClosure
    return self
  }
  func with(canHandleRouteCallsCount: Int) -> MainCoordinatorMock {
    self.canHandleRouteCallsCount = canHandleRouteCallsCount
    return self
  }
  func with(canHandleRouteReceivedRoute: Route?) -> MainCoordinatorMock {
    self.canHandleRouteReceivedRoute = canHandleRouteReceivedRoute
    return self
  }
  func with(canHandleRouteReceivedInvocations: [Route]) -> MainCoordinatorMock {
    self.canHandleRouteReceivedInvocations = canHandleRouteReceivedInvocations
    return self
  }
  func with(canHandleRouteReturnValue: Bool!) -> MainCoordinatorMock {
    self.canHandleRouteReturnValue = canHandleRouteReturnValue
    return self
  }
  func with(canHandleRouteClosure: ((Route) -> Bool)?) -> MainCoordinatorMock {
    self.canHandleRouteClosure = canHandleRouteClosure
    return self
  }
  func with(handleRouteNavigationStackAnimatedCallsCount: Int) -> MainCoordinatorMock {
    self.handleRouteNavigationStackAnimatedCallsCount = handleRouteNavigationStackAnimatedCallsCount
    return self
  }
  func with(handleRouteNavigationStackAnimatedReceivedArguments: (route: Route, navigationStack: [UIViewController], animated: Bool)?) -> MainCoordinatorMock {
    self.handleRouteNavigationStackAnimatedReceivedArguments = handleRouteNavigationStackAnimatedReceivedArguments
    return self
  }
  func with(handleRouteNavigationStackAnimatedReceivedInvocations: [(route: Route, navigationStack: [UIViewController], animated: Bool)]) -> MainCoordinatorMock {
    self.handleRouteNavigationStackAnimatedReceivedInvocations = handleRouteNavigationStackAnimatedReceivedInvocations
    return self
  }
  func with(handleRouteNavigationStackAnimatedReturnValue: Bool!) -> MainCoordinatorMock {
    self.handleRouteNavigationStackAnimatedReturnValue = handleRouteNavigationStackAnimatedReturnValue
    return self
  }
  func with(handleRouteNavigationStackAnimatedClosure: ((Route, [UIViewController], Bool) -> Bool)?) -> MainCoordinatorMock {
    self.handleRouteNavigationStackAnimatedClosure = handleRouteNavigationStackAnimatedClosure
    return self
  }
}
extension NavigationControllerViewControllersDelegateMock {
  func with(navigationControllerDidChangeViewControllersCallsCount: Int) -> NavigationControllerViewControllersDelegateMock {
    self.navigationControllerDidChangeViewControllersCallsCount = navigationControllerDidChangeViewControllersCallsCount
    return self
  }
  func with(navigationControllerDidChangeViewControllersReceivedNavigationController: NavigationController?) -> NavigationControllerViewControllersDelegateMock {
    self.navigationControllerDidChangeViewControllersReceivedNavigationController = navigationControllerDidChangeViewControllersReceivedNavigationController
    return self
  }
  func with(navigationControllerDidChangeViewControllersReceivedInvocations: [NavigationController]) -> NavigationControllerViewControllersDelegateMock {
    self.navigationControllerDidChangeViewControllersReceivedInvocations = navigationControllerDidChangeViewControllersReceivedInvocations
    return self
  }
  func with(navigationControllerDidChangeViewControllersClosure: ((NavigationController) -> Void)?) -> NavigationControllerViewControllersDelegateMock {
    self.navigationControllerDidChangeViewControllersClosure = navigationControllerDidChangeViewControllersClosure
    return self
  }
}
extension NetworkServiceMock {
  func with(fetchRepositoriesThrowableError: Error?) -> NetworkServiceMock {
    self.fetchRepositoriesThrowableError = fetchRepositoriesThrowableError
    return self
  }
  func with(fetchRepositoriesCallsCount: Int) -> NetworkServiceMock {
    self.fetchRepositoriesCallsCount = fetchRepositoriesCallsCount
    return self
  }
  func with(fetchRepositoriesReturnValue: [Repository]!) -> NetworkServiceMock {
    self.fetchRepositoriesReturnValue = fetchRepositoriesReturnValue
    return self
  }
  func with(fetchRepositoriesClosure: (() throws -> [Repository])?) -> NetworkServiceMock {
    self.fetchRepositoriesClosure = fetchRepositoriesClosure
    return self
  }
}
extension RepositoryListCoordinatorMock {
  func with(underlyingViewController: ViewController!) -> RepositoryListCoordinatorMock {
    self.underlyingViewController = underlyingViewController
    return self
  }
  func with(navigationController: NavigationController?) -> RepositoryListCoordinatorMock {
    self.navigationController = navigationController
    return self
  }
  func with(rootViewController: UIViewController?) -> RepositoryListCoordinatorMock {
    self.rootViewController = rootViewController
    return self
  }
  func with(haveAnyChildrenCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.haveAnyChildrenCallsCount = haveAnyChildrenCallsCount
    return self
  }
  func with(haveAnyChildrenReturnValue: Bool!) -> RepositoryListCoordinatorMock {
    self.haveAnyChildrenReturnValue = haveAnyChildrenReturnValue
    return self
  }
  func with(haveAnyChildrenClosure: (() -> Bool)?) -> RepositoryListCoordinatorMock {
    self.haveAnyChildrenClosure = haveAnyChildrenClosure
    return self
  }
  func with(addChildCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.addChildCallsCount = addChildCallsCount
    return self
  }
  func with(addChildReceivedCoordinator: Coordinator?) -> RepositoryListCoordinatorMock {
    self.addChildReceivedCoordinator = addChildReceivedCoordinator
    return self
  }
  func with(addChildReceivedInvocations: [Coordinator]) -> RepositoryListCoordinatorMock {
    self.addChildReceivedInvocations = addChildReceivedInvocations
    return self
  }
  func with(addChildClosure: ((Coordinator) -> Void)?) -> RepositoryListCoordinatorMock {
    self.addChildClosure = addChildClosure
    return self
  }
  func with(childDidFinishCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.childDidFinishCallsCount = childDidFinishCallsCount
    return self
  }
  func with(childDidFinishReceivedCoordinator: Coordinator?) -> RepositoryListCoordinatorMock {
    self.childDidFinishReceivedCoordinator = childDidFinishReceivedCoordinator
    return self
  }
  func with(childDidFinishReceivedInvocations: [Coordinator]) -> RepositoryListCoordinatorMock {
    self.childDidFinishReceivedInvocations = childDidFinishReceivedInvocations
    return self
  }
  func with(childDidFinishClosure: ((Coordinator) -> Void)?) -> RepositoryListCoordinatorMock {
    self.childDidFinishClosure = childDidFinishClosure
    return self
  }
  func with(setNavigationControllerCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.setNavigationControllerCallsCount = setNavigationControllerCallsCount
    return self
  }
  func with(setNavigationControllerReceivedNavigationController: NavigationController?) -> RepositoryListCoordinatorMock {
    self.setNavigationControllerReceivedNavigationController = setNavigationControllerReceivedNavigationController
    return self
  }
  func with(setNavigationControllerReceivedInvocations: [NavigationController?]) -> RepositoryListCoordinatorMock {
    self.setNavigationControllerReceivedInvocations = setNavigationControllerReceivedInvocations
    return self
  }
  func with(setNavigationControllerClosure: ((NavigationController?) -> Void)?) -> RepositoryListCoordinatorMock {
    self.setNavigationControllerClosure = setNavigationControllerClosure
    return self
  }
  func with(startFromActionCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.startFromActionCallsCount = startFromActionCallsCount
    return self
  }
  func with(startFromActionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction)?) -> RepositoryListCoordinatorMock {
    self.startFromActionReceivedArguments = startFromActionReceivedArguments
    return self
  }
  func with(startFromActionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction)]) -> RepositoryListCoordinatorMock {
    self.startFromActionReceivedInvocations = startFromActionReceivedInvocations
    return self
  }
  func with(startFromActionClosure: ((Coordinator, CoordinatorAction) -> Void)?) -> RepositoryListCoordinatorMock {
    self.startFromActionClosure = startFromActionClosure
    return self
  }
  func with(startFromActionCompletionCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.startFromActionCompletionCallsCount = startFromActionCompletionCallsCount
    return self
  }
  func with(startFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?) -> RepositoryListCoordinatorMock {
    self.startFromActionCompletionReceivedArguments = startFromActionCompletionReceivedArguments
    return self
  }
  func with(startFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)]) -> RepositoryListCoordinatorMock {
    self.startFromActionCompletionReceivedInvocations = startFromActionCompletionReceivedInvocations
    return self
  }
  func with(startFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?) -> RepositoryListCoordinatorMock {
    self.startFromActionCompletionClosure = startFromActionCompletionClosure
    return self
  }
  func with(addToParentCoordinatorCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.addToParentCoordinatorCallsCount = addToParentCoordinatorCallsCount
    return self
  }
  func with(addToParentCoordinatorReceivedParentCoordinator: Coordinator?) -> RepositoryListCoordinatorMock {
    self.addToParentCoordinatorReceivedParentCoordinator = addToParentCoordinatorReceivedParentCoordinator
    return self
  }
  func with(addToParentCoordinatorReceivedInvocations: [Coordinator]) -> RepositoryListCoordinatorMock {
    self.addToParentCoordinatorReceivedInvocations = addToParentCoordinatorReceivedInvocations
    return self
  }
  func with(addToParentCoordinatorClosure: ((Coordinator) -> Void)?) -> RepositoryListCoordinatorMock {
    self.addToParentCoordinatorClosure = addToParentCoordinatorClosure
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionCallsCount = addToViewControllersHierarchyFromActionCompletionCallsCount
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?) -> RepositoryListCoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionReceivedArguments = addToViewControllersHierarchyFromActionCompletionReceivedArguments
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)]) -> RepositoryListCoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionReceivedInvocations = addToViewControllersHierarchyFromActionCompletionReceivedInvocations
    return self
  }
  func with(addToViewControllersHierarchyFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?) -> RepositoryListCoordinatorMock {
    self.addToViewControllersHierarchyFromActionCompletionClosure = addToViewControllersHierarchyFromActionCompletionClosure
    return self
  }
  func with(closeAnimatedCompletionCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.closeAnimatedCompletionCallsCount = closeAnimatedCompletionCallsCount
    return self
  }
  func with(closeAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> RepositoryListCoordinatorMock {
    self.closeAnimatedCompletionReceivedArguments = closeAnimatedCompletionReceivedArguments
    return self
  }
  func with(closeAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> RepositoryListCoordinatorMock {
    self.closeAnimatedCompletionReceivedInvocations = closeAnimatedCompletionReceivedInvocations
    return self
  }
  func with(closeAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> RepositoryListCoordinatorMock {
    self.closeAnimatedCompletionClosure = closeAnimatedCompletionClosure
    return self
  }
  func with(closeAndFinishAnimatedCompletionCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.closeAndFinishAnimatedCompletionCallsCount = closeAndFinishAnimatedCompletionCallsCount
    return self
  }
  func with(closeAndFinishAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> RepositoryListCoordinatorMock {
    self.closeAndFinishAnimatedCompletionReceivedArguments = closeAndFinishAnimatedCompletionReceivedArguments
    return self
  }
  func with(closeAndFinishAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> RepositoryListCoordinatorMock {
    self.closeAndFinishAnimatedCompletionReceivedInvocations = closeAndFinishAnimatedCompletionReceivedInvocations
    return self
  }
  func with(closeAndFinishAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> RepositoryListCoordinatorMock {
    self.closeAndFinishAnimatedCompletionClosure = closeAndFinishAnimatedCompletionClosure
    return self
  }
  func with(removeFromParentCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.removeFromParentCallsCount = removeFromParentCallsCount
    return self
  }
  func with(removeFromParentClosure: (() -> Void)?) -> RepositoryListCoordinatorMock {
    self.removeFromParentClosure = removeFromParentClosure
    return self
  }
  func with(popToSelfAnimatedCompletionCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.popToSelfAnimatedCompletionCallsCount = popToSelfAnimatedCompletionCallsCount
    return self
  }
  func with(popToSelfAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> RepositoryListCoordinatorMock {
    self.popToSelfAnimatedCompletionReceivedArguments = popToSelfAnimatedCompletionReceivedArguments
    return self
  }
  func with(popToSelfAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> RepositoryListCoordinatorMock {
    self.popToSelfAnimatedCompletionReceivedInvocations = popToSelfAnimatedCompletionReceivedInvocations
    return self
  }
  func with(popToSelfAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> RepositoryListCoordinatorMock {
    self.popToSelfAnimatedCompletionClosure = popToSelfAnimatedCompletionClosure
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionCallsCount: Int) -> RepositoryListCoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionCallsCount = dismissRootModalCoordinatorAnimatedCompletionCallsCount
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?) -> RepositoryListCoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionReceivedArguments = dismissRootModalCoordinatorAnimatedCompletionReceivedArguments
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)]) -> RepositoryListCoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations = dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations
    return self
  }
  func with(dismissRootModalCoordinatorAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?) -> RepositoryListCoordinatorMock {
    self.dismissRootModalCoordinatorAnimatedCompletionClosure = dismissRootModalCoordinatorAnimatedCompletionClosure
    return self
  }
}
extension RepositoryListViewModelMock {
  func with(underlyingState: CommonViewModelState!) -> RepositoryListViewModelMock {
    self.underlyingState = underlyingState
    return self
  }
  func with(onNeedsReload: (() -> Void)?) -> RepositoryListViewModelMock {
    self.onNeedsReload = onNeedsReload
    return self
  }
  func with(onStateChanged: ((CommonViewModelState) -> Void)?) -> RepositoryListViewModelMock {
    self.onStateChanged = onStateChanged
    return self
  }
  func with(onClose: (() -> Void)?) -> RepositoryListViewModelMock {
    self.onClose = onClose
    return self
  }
  func with(onGoBack: (() -> Void)?) -> RepositoryListViewModelMock {
    self.onGoBack = onGoBack
    return self
  }
  func with(underlyingScreen: AppScreen!) -> RepositoryListViewModelMock {
    self.underlyingScreen = underlyingScreen
    return self
  }
  func with(underlyingHeaderConfiguration: HeaderConfiguration!) -> RepositoryListViewModelMock {
    self.underlyingHeaderConfiguration = underlyingHeaderConfiguration
    return self
  }
  func with(setupInTableViewCallsCount: Int) -> RepositoryListViewModelMock {
    self.setupInTableViewCallsCount = setupInTableViewCallsCount
    return self
  }
  func with(setupInTableViewReceivedTableView: UITableView?) -> RepositoryListViewModelMock {
    self.setupInTableViewReceivedTableView = setupInTableViewReceivedTableView
    return self
  }
  func with(setupInTableViewReceivedInvocations: [UITableView]) -> RepositoryListViewModelMock {
    self.setupInTableViewReceivedInvocations = setupInTableViewReceivedInvocations
    return self
  }
  func with(setupInTableViewClosure: ((UITableView) -> Void)?) -> RepositoryListViewModelMock {
    self.setupInTableViewClosure = setupInTableViewClosure
    return self
  }
  func with(viewDidAppearCallsCount: Int) -> RepositoryListViewModelMock {
    self.viewDidAppearCallsCount = viewDidAppearCallsCount
    return self
  }
  func with(viewDidAppearClosure: (() -> Void)?) -> RepositoryListViewModelMock {
    self.viewDidAppearClosure = viewDidAppearClosure
    return self
  }
  func with(canCloseCallsCount: Int) -> RepositoryListViewModelMock {
    self.canCloseCallsCount = canCloseCallsCount
    return self
  }
  func with(canCloseReturnValue: Bool!) -> RepositoryListViewModelMock {
    self.canCloseReturnValue = canCloseReturnValue
    return self
  }
  func with(canCloseClosure: (() -> Bool)?) -> RepositoryListViewModelMock {
    self.canCloseClosure = canCloseClosure
    return self
  }
  func with(canGoBackCallsCount: Int) -> RepositoryListViewModelMock {
    self.canGoBackCallsCount = canGoBackCallsCount
    return self
  }
  func with(canGoBackReturnValue: Bool!) -> RepositoryListViewModelMock {
    self.canGoBackReturnValue = canGoBackReturnValue
    return self
  }
  func with(canGoBackClosure: (() -> Bool)?) -> RepositoryListViewModelMock {
    self.canGoBackClosure = canGoBackClosure
    return self
  }
}
extension RoutingControllerMock {
  func with(mainRouter: MainRouter?) -> RoutingControllerMock {
    self.mainRouter = mainRouter
    return self
  }
  func with(underlyingHasPendingRoute: Bool!) -> RoutingControllerMock {
    self.underlyingHasPendingRoute = underlyingHasPendingRoute
    return self
  }
  func with(pendingRoute: Route?) -> RoutingControllerMock {
    self.pendingRoute = pendingRoute
    return self
  }
  func with(pendingRouteSource: RouteSource?) -> RoutingControllerMock {
    self.pendingRouteSource = pendingRouteSource
    return self
  }
  func with(canHandleUrlCallsCount: Int) -> RoutingControllerMock {
    self.canHandleUrlCallsCount = canHandleUrlCallsCount
    return self
  }
  func with(canHandleUrlReceivedUrl: URL?) -> RoutingControllerMock {
    self.canHandleUrlReceivedUrl = canHandleUrlReceivedUrl
    return self
  }
  func with(canHandleUrlReceivedInvocations: [URL]) -> RoutingControllerMock {
    self.canHandleUrlReceivedInvocations = canHandleUrlReceivedInvocations
    return self
  }
  func with(canHandleUrlReturnValue: Bool!) -> RoutingControllerMock {
    self.canHandleUrlReturnValue = canHandleUrlReturnValue
    return self
  }
  func with(canHandleUrlClosure: ((URL) -> Bool)?) -> RoutingControllerMock {
    self.canHandleUrlClosure = canHandleUrlClosure
    return self
  }
  func with(handleUrlSourceCallsCount: Int) -> RoutingControllerMock {
    self.handleUrlSourceCallsCount = handleUrlSourceCallsCount
    return self
  }
  func with(handleUrlSourceReceivedArguments: (url: URL, source: RouteSource)?) -> RoutingControllerMock {
    self.handleUrlSourceReceivedArguments = handleUrlSourceReceivedArguments
    return self
  }
  func with(handleUrlSourceReceivedInvocations: [(url: URL, source: RouteSource)]) -> RoutingControllerMock {
    self.handleUrlSourceReceivedInvocations = handleUrlSourceReceivedInvocations
    return self
  }
  func with(handleUrlSourceReturnValue: Bool!) -> RoutingControllerMock {
    self.handleUrlSourceReturnValue = handleUrlSourceReturnValue
    return self
  }
  func with(handleUrlSourceClosure: ((URL, RouteSource) -> Bool)?) -> RoutingControllerMock {
    self.handleUrlSourceClosure = handleUrlSourceClosure
    return self
  }
  func with(handleRouteSourceCallsCount: Int) -> RoutingControllerMock {
    self.handleRouteSourceCallsCount = handleRouteSourceCallsCount
    return self
  }
  func with(handleRouteSourceReceivedArguments: (route: Route, source: RouteSource)?) -> RoutingControllerMock {
    self.handleRouteSourceReceivedArguments = handleRouteSourceReceivedArguments
    return self
  }
  func with(handleRouteSourceReceivedInvocations: [(route: Route, source: RouteSource)]) -> RoutingControllerMock {
    self.handleRouteSourceReceivedInvocations = handleRouteSourceReceivedInvocations
    return self
  }
  func with(handleRouteSourceClosure: ((Route, RouteSource) -> Void)?) -> RoutingControllerMock {
    self.handleRouteSourceClosure = handleRouteSourceClosure
    return self
  }
  func with(didEnterBackgroundCallsCount: Int) -> RoutingControllerMock {
    self.didEnterBackgroundCallsCount = didEnterBackgroundCallsCount
    return self
  }
  func with(didEnterBackgroundClosure: (() -> Void)?) -> RoutingControllerMock {
    self.didEnterBackgroundClosure = didEnterBackgroundClosure
    return self
  }
  func with(activeCoordinatorChangedCallsCount: Int) -> RoutingControllerMock {
    self.activeCoordinatorChangedCallsCount = activeCoordinatorChangedCallsCount
    return self
  }
  func with(activeCoordinatorChangedClosure: (() -> Void)?) -> RoutingControllerMock {
    self.activeCoordinatorChangedClosure = activeCoordinatorChangedClosure
    return self
  }
  func with(handleCurrentRouteCallsCount: Int) -> RoutingControllerMock {
    self.handleCurrentRouteCallsCount = handleCurrentRouteCallsCount
    return self
  }
  func with(handleCurrentRouteClosure: (() -> Void)?) -> RoutingControllerMock {
    self.handleCurrentRouteClosure = handleCurrentRouteClosure
    return self
  }
  func with(addObserverCallsCount: Int) -> RoutingControllerMock {
    self.addObserverCallsCount = addObserverCallsCount
    return self
  }
  func with(addObserverReceivedObserver: RoutingControllerEventObserver?) -> RoutingControllerMock {
    self.addObserverReceivedObserver = addObserverReceivedObserver
    return self
  }
  func with(addObserverReceivedInvocations: [RoutingControllerEventObserver]) -> RoutingControllerMock {
    self.addObserverReceivedInvocations = addObserverReceivedInvocations
    return self
  }
  func with(addObserverClosure: ((RoutingControllerEventObserver) -> Void)?) -> RoutingControllerMock {
    self.addObserverClosure = addObserverClosure
    return self
  }
  func with(removeObserverCallsCount: Int) -> RoutingControllerMock {
    self.removeObserverCallsCount = removeObserverCallsCount
    return self
  }
  func with(removeObserverReceivedObserverID: UUID?) -> RoutingControllerMock {
    self.removeObserverReceivedObserverID = removeObserverReceivedObserverID
    return self
  }
  func with(removeObserverReceivedInvocations: [UUID]) -> RoutingControllerMock {
    self.removeObserverReceivedInvocations = removeObserverReceivedInvocations
    return self
  }
  func with(removeObserverClosure: ((UUID) -> Void)?) -> RoutingControllerMock {
    self.removeObserverClosure = removeObserverClosure
    return self
  }
}
