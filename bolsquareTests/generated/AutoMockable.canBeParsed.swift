// Generated using Sourcery 2.2.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//swiftlint:disable all

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

@testable import bolsquare














class ContentDataSourceMock: ContentDataSource, AutoLenses {
    var cellProvider: ContentDataSourceCellProvider?
    var cellContentInsets: ContentInsets {
        get { return underlyingCellContentInsets }
        set(value) { underlyingCellContentInsets = value }
    }
    var underlyingCellContentInsets: ContentInsets!

    //MARK: - setup

    var setupInTableViewCallsCount = 0
    var setupInTableViewCalled: Bool {
        return setupInTableViewCallsCount > 0
    }
    var setupInTableViewReceivedTableView: UITableView?
    var setupInTableViewReceivedInvocations: [UITableView] = []
    var setupInTableViewClosure: ((UITableView) -> Void)?

    func setup(inTableView tableView: UITableView) {
        setupInTableViewCallsCount += 1
        setupInTableViewReceivedTableView = tableView
        setupInTableViewReceivedInvocations.append(tableView)
        setupInTableViewClosure?(tableView)
    }

    //MARK: - load

    var loadSectionsCallsCount = 0
    var loadSectionsCalled: Bool {
        return loadSectionsCallsCount > 0
    }
    var loadSectionsReceivedSections: [[ContentItemDefinition]]?
    var loadSectionsReceivedInvocations: [[[ContentItemDefinition]]] = []
    var loadSectionsClosure: (([[ContentItemDefinition]]) -> Void)?

    func load(sections: [[ContentItemDefinition]]) {
        loadSectionsCallsCount += 1
        loadSectionsReceivedSections = sections
        loadSectionsReceivedInvocations.append(sections)
        loadSectionsClosure?(sections)
    }

    //MARK: - load

    var loadItemsCallsCount = 0
    var loadItemsCalled: Bool {
        return loadItemsCallsCount > 0
    }
    var loadItemsReceivedItems: [ContentItemDefinition]?
    var loadItemsReceivedInvocations: [[ContentItemDefinition]] = []
    var loadItemsClosure: (([ContentItemDefinition]) -> Void)?

    func load(items: [ContentItemDefinition]) {
        loadItemsCallsCount += 1
        loadItemsReceivedItems = items
        loadItemsReceivedInvocations.append(items)
        loadItemsClosure?(items)
    }

    //MARK: - load

    var loadSectionItemsSectionCallsCount = 0
    var loadSectionItemsSectionCalled: Bool {
        return loadSectionItemsSectionCallsCount > 0
    }
    var loadSectionItemsSectionReceivedArguments: (sectionItems: [ContentItemDefinition], section: Int)?
    var loadSectionItemsSectionReceivedInvocations: [(sectionItems: [ContentItemDefinition], section: Int)] = []
    var loadSectionItemsSectionClosure: (([ContentItemDefinition], Int) -> Void)?

    func load(sectionItems: [ContentItemDefinition], section: Int) {
        loadSectionItemsSectionCallsCount += 1
        loadSectionItemsSectionReceivedArguments = (sectionItems: sectionItems, section: section)
        loadSectionItemsSectionReceivedInvocations.append((sectionItems: sectionItems, section: section))
        loadSectionItemsSectionClosure?(sectionItems, section)
    }

}
class ContentDataSourceCellProviderMock: ContentDataSourceCellProvider, AutoLenses {

    //MARK: - dataSourceCustomCell

    var dataSourceCustomCellForItemTableViewIndexPathCallsCount = 0
    var dataSourceCustomCellForItemTableViewIndexPathCalled: Bool {
        return dataSourceCustomCellForItemTableViewIndexPathCallsCount > 0
    }
    var dataSourceCustomCellForItemTableViewIndexPathReceivedArguments: (item: ContentItemDefinition, tableView: UITableView, indexPath: IndexPath)?
    var dataSourceCustomCellForItemTableViewIndexPathReceivedInvocations: [(item: ContentItemDefinition, tableView: UITableView, indexPath: IndexPath)] = []
    var dataSourceCustomCellForItemTableViewIndexPathReturnValue: UITableViewCell?
    var dataSourceCustomCellForItemTableViewIndexPathClosure: ((ContentItemDefinition, UITableView, IndexPath) -> UITableViewCell?)?

    func dataSourceCustomCell(forItem item: ContentItemDefinition, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        dataSourceCustomCellForItemTableViewIndexPathCallsCount += 1
        dataSourceCustomCellForItemTableViewIndexPathReceivedArguments = (item: item, tableView: tableView, indexPath: indexPath)
        dataSourceCustomCellForItemTableViewIndexPathReceivedInvocations.append((item: item, tableView: tableView, indexPath: indexPath))
        return dataSourceCustomCellForItemTableViewIndexPathClosure.map({ $0(item, tableView, indexPath) }) ?? dataSourceCustomCellForItemTableViewIndexPathReturnValue
    }

}
class CoordinatorMock: Coordinator, AutoLenses {
    var viewController: ViewController {
        get { return underlyingViewController }
        set(value) { underlyingViewController = value }
    }
    var underlyingViewController: ViewController!
    var navigationController: NavigationController?
    var rootViewController: UIViewController?

    //MARK: - haveAnyChildren

    var haveAnyChildrenCallsCount = 0
    var haveAnyChildrenCalled: Bool {
        return haveAnyChildrenCallsCount > 0
    }
    var haveAnyChildrenReturnValue: Bool!
    var haveAnyChildrenClosure: (() -> Bool)?

    func haveAnyChildren() -> Bool {
        haveAnyChildrenCallsCount += 1
        return haveAnyChildrenClosure.map({ $0() }) ?? haveAnyChildrenReturnValue
    }

    //MARK: - addChild

    var addChildCallsCount = 0
    var addChildCalled: Bool {
        return addChildCallsCount > 0
    }
    var addChildReceivedCoordinator: Coordinator?
    var addChildReceivedInvocations: [Coordinator] = []
    var addChildClosure: ((Coordinator) -> Void)?

    func addChild(_ coordinator: Coordinator) {
        addChildCallsCount += 1
        addChildReceivedCoordinator = coordinator
        addChildReceivedInvocations.append(coordinator)
        addChildClosure?(coordinator)
    }

    //MARK: - childDidFinish

    var childDidFinishCallsCount = 0
    var childDidFinishCalled: Bool {
        return childDidFinishCallsCount > 0
    }
    var childDidFinishReceivedCoordinator: Coordinator?
    var childDidFinishReceivedInvocations: [Coordinator] = []
    var childDidFinishClosure: ((Coordinator) -> Void)?

    func childDidFinish(_ coordinator: Coordinator) {
        childDidFinishCallsCount += 1
        childDidFinishReceivedCoordinator = coordinator
        childDidFinishReceivedInvocations.append(coordinator)
        childDidFinishClosure?(coordinator)
    }

    //MARK: - set

    var setNavigationControllerCallsCount = 0
    var setNavigationControllerCalled: Bool {
        return setNavigationControllerCallsCount > 0
    }
    var setNavigationControllerReceivedNavigationController: NavigationController?
    var setNavigationControllerReceivedInvocations: [NavigationController?] = []
    var setNavigationControllerClosure: ((NavigationController?) -> Void)?

    func set(navigationController: NavigationController?) {
        setNavigationControllerCallsCount += 1
        setNavigationControllerReceivedNavigationController = navigationController
        setNavigationControllerReceivedInvocations.append(navigationController)
        setNavigationControllerClosure?(navigationController)
    }

    //MARK: - start

    var startFromActionCallsCount = 0
    var startFromActionCalled: Bool {
        return startFromActionCallsCount > 0
    }
    var startFromActionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction)?
    var startFromActionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction)] = []
    var startFromActionClosure: ((Coordinator, CoordinatorAction) -> Void)?

    func start(from parentCoordinator: Coordinator, action: CoordinatorAction) {
        startFromActionCallsCount += 1
        startFromActionReceivedArguments = (parentCoordinator: parentCoordinator, action: action)
        startFromActionReceivedInvocations.append((parentCoordinator: parentCoordinator, action: action))
        startFromActionClosure?(parentCoordinator, action)
    }

    //MARK: - start

    var startFromActionCompletionCallsCount = 0
    var startFromActionCompletionCalled: Bool {
        return startFromActionCompletionCallsCount > 0
    }
    var startFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?
    var startFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)] = []
    var startFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?

    func start(from parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?) {
        startFromActionCompletionCallsCount += 1
        startFromActionCompletionReceivedArguments = (parentCoordinator: parentCoordinator, action: action, completion: completion)
        startFromActionCompletionReceivedInvocations.append((parentCoordinator: parentCoordinator, action: action, completion: completion))
        startFromActionCompletionClosure?(parentCoordinator, action, completion)
    }

    //MARK: - addToParentCoordinator

    var addToParentCoordinatorCallsCount = 0
    var addToParentCoordinatorCalled: Bool {
        return addToParentCoordinatorCallsCount > 0
    }
    var addToParentCoordinatorReceivedParentCoordinator: Coordinator?
    var addToParentCoordinatorReceivedInvocations: [Coordinator] = []
    var addToParentCoordinatorClosure: ((Coordinator) -> Void)?

    func addToParentCoordinator(_ parentCoordinator: Coordinator) {
        addToParentCoordinatorCallsCount += 1
        addToParentCoordinatorReceivedParentCoordinator = parentCoordinator
        addToParentCoordinatorReceivedInvocations.append(parentCoordinator)
        addToParentCoordinatorClosure?(parentCoordinator)
    }

    //MARK: - addToViewControllersHierarchy

    var addToViewControllersHierarchyFromActionCompletionCallsCount = 0
    var addToViewControllersHierarchyFromActionCompletionCalled: Bool {
        return addToViewControllersHierarchyFromActionCompletionCallsCount > 0
    }
    var addToViewControllersHierarchyFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?
    var addToViewControllersHierarchyFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)] = []
    var addToViewControllersHierarchyFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?

    func addToViewControllersHierarchy(from parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?) {
        addToViewControllersHierarchyFromActionCompletionCallsCount += 1
        addToViewControllersHierarchyFromActionCompletionReceivedArguments = (parentCoordinator: parentCoordinator, action: action, completion: completion)
        addToViewControllersHierarchyFromActionCompletionReceivedInvocations.append((parentCoordinator: parentCoordinator, action: action, completion: completion))
        addToViewControllersHierarchyFromActionCompletionClosure?(parentCoordinator, action, completion)
    }

    //MARK: - close

    var closeAnimatedCompletionCallsCount = 0
    var closeAnimatedCompletionCalled: Bool {
        return closeAnimatedCompletionCallsCount > 0
    }
    var closeAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var closeAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var closeAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func close(animated: Bool, completion: (() -> Void)?) {
        closeAnimatedCompletionCallsCount += 1
        closeAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        closeAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        closeAnimatedCompletionClosure?(animated, completion)
    }

    //MARK: - closeAndFinish

    var closeAndFinishAnimatedCompletionCallsCount = 0
    var closeAndFinishAnimatedCompletionCalled: Bool {
        return closeAndFinishAnimatedCompletionCallsCount > 0
    }
    var closeAndFinishAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var closeAndFinishAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var closeAndFinishAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func closeAndFinish(animated: Bool, completion: (() -> Void)?) {
        closeAndFinishAnimatedCompletionCallsCount += 1
        closeAndFinishAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        closeAndFinishAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        closeAndFinishAnimatedCompletionClosure?(animated, completion)
    }

    //MARK: - removeFromParent

    var removeFromParentCallsCount = 0
    var removeFromParentCalled: Bool {
        return removeFromParentCallsCount > 0
    }
    var removeFromParentClosure: (() -> Void)?

    func removeFromParent() {
        removeFromParentCallsCount += 1
        removeFromParentClosure?()
    }

    //MARK: - popToSelf

    var popToSelfAnimatedCompletionCallsCount = 0
    var popToSelfAnimatedCompletionCalled: Bool {
        return popToSelfAnimatedCompletionCallsCount > 0
    }
    var popToSelfAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var popToSelfAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var popToSelfAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func popToSelf(animated: Bool, completion: (() -> Void)?) {
        popToSelfAnimatedCompletionCallsCount += 1
        popToSelfAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        popToSelfAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        popToSelfAnimatedCompletionClosure?(animated, completion)
    }

    //MARK: - dismissRootModalCoordinator

    var dismissRootModalCoordinatorAnimatedCompletionCallsCount = 0
    var dismissRootModalCoordinatorAnimatedCompletionCalled: Bool {
        return dismissRootModalCoordinatorAnimatedCompletionCallsCount > 0
    }
    var dismissRootModalCoordinatorAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var dismissRootModalCoordinatorAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func dismissRootModalCoordinator(animated: Bool, completion: (() -> Void)?) {
        dismissRootModalCoordinatorAnimatedCompletionCallsCount += 1
        dismissRootModalCoordinatorAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        dismissRootModalCoordinatorAnimatedCompletionClosure?(animated, completion)
    }

}
class FactoryMock: Factory, AutoLenses {

    //MARK: - contentDataSource

    var contentDataSourceCallsCount = 0
    var contentDataSourceCalled: Bool {
        return contentDataSourceCallsCount > 0
    }
    var contentDataSourceReturnValue: ContentDataSource!
    var contentDataSourceClosure: (() -> ContentDataSource)?

    func contentDataSource() -> ContentDataSource {
        contentDataSourceCallsCount += 1
        return contentDataSourceClosure.map({ $0() }) ?? contentDataSourceReturnValue
    }

    //MARK: - mainCoordinator

    var mainCoordinatorInjectorCallsCount = 0
    var mainCoordinatorInjectorCalled: Bool {
        return mainCoordinatorInjectorCallsCount > 0
    }
    var mainCoordinatorInjectorReceivedInjector: MainCoordinatorInjectorImpl?
    var mainCoordinatorInjectorReceivedInvocations: [MainCoordinatorInjectorImpl] = []
    var mainCoordinatorInjectorReturnValue: MainCoordinator!
    var mainCoordinatorInjectorClosure: ((MainCoordinatorInjectorImpl) -> MainCoordinator)?

    func mainCoordinator(injector: MainCoordinatorInjectorImpl) -> MainCoordinator {
        mainCoordinatorInjectorCallsCount += 1
        mainCoordinatorInjectorReceivedInjector = injector
        mainCoordinatorInjectorReceivedInvocations.append(injector)
        return mainCoordinatorInjectorClosure.map({ $0(injector) }) ?? mainCoordinatorInjectorReturnValue
    }

    //MARK: - mainRoutingViewController

    var mainRoutingViewControllerCallsCount = 0
    var mainRoutingViewControllerCalled: Bool {
        return mainRoutingViewControllerCallsCount > 0
    }
    var mainRoutingViewControllerReturnValue: MainRoutingViewController!
    var mainRoutingViewControllerClosure: (() -> MainRoutingViewController)?

    func mainRoutingViewController() -> MainRoutingViewController {
        mainRoutingViewControllerCallsCount += 1
        return mainRoutingViewControllerClosure.map({ $0() }) ?? mainRoutingViewControllerReturnValue
    }

    //MARK: - repositoryListCoordinator

    var repositoryListCoordinatorInjectorCallsCount = 0
    var repositoryListCoordinatorInjectorCalled: Bool {
        return repositoryListCoordinatorInjectorCallsCount > 0
    }
    var repositoryListCoordinatorInjectorReceivedInjector: RepositoryListCoordinatorInjectorImpl?
    var repositoryListCoordinatorInjectorReceivedInvocations: [RepositoryListCoordinatorInjectorImpl] = []
    var repositoryListCoordinatorInjectorReturnValue: RepositoryListCoordinator!
    var repositoryListCoordinatorInjectorClosure: ((RepositoryListCoordinatorInjectorImpl) -> RepositoryListCoordinator)?

    func repositoryListCoordinator(injector: RepositoryListCoordinatorInjectorImpl) -> RepositoryListCoordinator {
        repositoryListCoordinatorInjectorCallsCount += 1
        repositoryListCoordinatorInjectorReceivedInjector = injector
        repositoryListCoordinatorInjectorReceivedInvocations.append(injector)
        return repositoryListCoordinatorInjectorClosure.map({ $0(injector) }) ?? repositoryListCoordinatorInjectorReturnValue
    }

    //MARK: - repositoryListViewModel

    var repositoryListViewModelInjectorCallsCount = 0
    var repositoryListViewModelInjectorCalled: Bool {
        return repositoryListViewModelInjectorCallsCount > 0
    }
    var repositoryListViewModelInjectorReceivedInjector: RepositoryListViewModelInjectorImpl?
    var repositoryListViewModelInjectorReceivedInvocations: [RepositoryListViewModelInjectorImpl] = []
    var repositoryListViewModelInjectorReturnValue: RepositoryListViewModel!
    var repositoryListViewModelInjectorClosure: ((RepositoryListViewModelInjectorImpl) -> RepositoryListViewModel)?

    func repositoryListViewModel(injector: RepositoryListViewModelInjectorImpl) -> RepositoryListViewModel {
        repositoryListViewModelInjectorCallsCount += 1
        repositoryListViewModelInjectorReceivedInjector = injector
        repositoryListViewModelInjectorReceivedInvocations.append(injector)
        return repositoryListViewModelInjectorClosure.map({ $0(injector) }) ?? repositoryListViewModelInjectorReturnValue
    }

    //MARK: - routeBuilder

    var routeBuilderCallsCount = 0
    var routeBuilderCalled: Bool {
        return routeBuilderCallsCount > 0
    }
    var routeBuilderReturnValue: RouteBuilder!
    var routeBuilderClosure: (() -> RouteBuilder)?

    func routeBuilder() -> RouteBuilder {
        routeBuilderCallsCount += 1
        return routeBuilderClosure.map({ $0() }) ?? routeBuilderReturnValue
    }

}
class MainCoordinatorMock: MainCoordinator, AutoLenses {
    var viewController: ViewController {
        get { return underlyingViewController }
        set(value) { underlyingViewController = value }
    }
    var underlyingViewController: ViewController!
    var navigationController: NavigationController?
    var rootViewController: UIViewController?

    //MARK: - haveAnyChildren

    var haveAnyChildrenCallsCount = 0
    var haveAnyChildrenCalled: Bool {
        return haveAnyChildrenCallsCount > 0
    }
    var haveAnyChildrenReturnValue: Bool!
    var haveAnyChildrenClosure: (() -> Bool)?

    func haveAnyChildren() -> Bool {
        haveAnyChildrenCallsCount += 1
        return haveAnyChildrenClosure.map({ $0() }) ?? haveAnyChildrenReturnValue
    }

    //MARK: - addChild

    var addChildCallsCount = 0
    var addChildCalled: Bool {
        return addChildCallsCount > 0
    }
    var addChildReceivedCoordinator: Coordinator?
    var addChildReceivedInvocations: [Coordinator] = []
    var addChildClosure: ((Coordinator) -> Void)?

    func addChild(_ coordinator: Coordinator) {
        addChildCallsCount += 1
        addChildReceivedCoordinator = coordinator
        addChildReceivedInvocations.append(coordinator)
        addChildClosure?(coordinator)
    }

    //MARK: - childDidFinish

    var childDidFinishCallsCount = 0
    var childDidFinishCalled: Bool {
        return childDidFinishCallsCount > 0
    }
    var childDidFinishReceivedCoordinator: Coordinator?
    var childDidFinishReceivedInvocations: [Coordinator] = []
    var childDidFinishClosure: ((Coordinator) -> Void)?

    func childDidFinish(_ coordinator: Coordinator) {
        childDidFinishCallsCount += 1
        childDidFinishReceivedCoordinator = coordinator
        childDidFinishReceivedInvocations.append(coordinator)
        childDidFinishClosure?(coordinator)
    }

    //MARK: - set

    var setNavigationControllerCallsCount = 0
    var setNavigationControllerCalled: Bool {
        return setNavigationControllerCallsCount > 0
    }
    var setNavigationControllerReceivedNavigationController: NavigationController?
    var setNavigationControllerReceivedInvocations: [NavigationController?] = []
    var setNavigationControllerClosure: ((NavigationController?) -> Void)?

    func set(navigationController: NavigationController?) {
        setNavigationControllerCallsCount += 1
        setNavigationControllerReceivedNavigationController = navigationController
        setNavigationControllerReceivedInvocations.append(navigationController)
        setNavigationControllerClosure?(navigationController)
    }

    //MARK: - start

    var startFromActionCallsCount = 0
    var startFromActionCalled: Bool {
        return startFromActionCallsCount > 0
    }
    var startFromActionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction)?
    var startFromActionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction)] = []
    var startFromActionClosure: ((Coordinator, CoordinatorAction) -> Void)?

    func start(from parentCoordinator: Coordinator, action: CoordinatorAction) {
        startFromActionCallsCount += 1
        startFromActionReceivedArguments = (parentCoordinator: parentCoordinator, action: action)
        startFromActionReceivedInvocations.append((parentCoordinator: parentCoordinator, action: action))
        startFromActionClosure?(parentCoordinator, action)
    }

    //MARK: - start

    var startFromActionCompletionCallsCount = 0
    var startFromActionCompletionCalled: Bool {
        return startFromActionCompletionCallsCount > 0
    }
    var startFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?
    var startFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)] = []
    var startFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?

    func start(from parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?) {
        startFromActionCompletionCallsCount += 1
        startFromActionCompletionReceivedArguments = (parentCoordinator: parentCoordinator, action: action, completion: completion)
        startFromActionCompletionReceivedInvocations.append((parentCoordinator: parentCoordinator, action: action, completion: completion))
        startFromActionCompletionClosure?(parentCoordinator, action, completion)
    }

    //MARK: - addToParentCoordinator

    var addToParentCoordinatorCallsCount = 0
    var addToParentCoordinatorCalled: Bool {
        return addToParentCoordinatorCallsCount > 0
    }
    var addToParentCoordinatorReceivedParentCoordinator: Coordinator?
    var addToParentCoordinatorReceivedInvocations: [Coordinator] = []
    var addToParentCoordinatorClosure: ((Coordinator) -> Void)?

    func addToParentCoordinator(_ parentCoordinator: Coordinator) {
        addToParentCoordinatorCallsCount += 1
        addToParentCoordinatorReceivedParentCoordinator = parentCoordinator
        addToParentCoordinatorReceivedInvocations.append(parentCoordinator)
        addToParentCoordinatorClosure?(parentCoordinator)
    }

    //MARK: - addToViewControllersHierarchy

    var addToViewControllersHierarchyFromActionCompletionCallsCount = 0
    var addToViewControllersHierarchyFromActionCompletionCalled: Bool {
        return addToViewControllersHierarchyFromActionCompletionCallsCount > 0
    }
    var addToViewControllersHierarchyFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?
    var addToViewControllersHierarchyFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)] = []
    var addToViewControllersHierarchyFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?

    func addToViewControllersHierarchy(from parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?) {
        addToViewControllersHierarchyFromActionCompletionCallsCount += 1
        addToViewControllersHierarchyFromActionCompletionReceivedArguments = (parentCoordinator: parentCoordinator, action: action, completion: completion)
        addToViewControllersHierarchyFromActionCompletionReceivedInvocations.append((parentCoordinator: parentCoordinator, action: action, completion: completion))
        addToViewControllersHierarchyFromActionCompletionClosure?(parentCoordinator, action, completion)
    }

    //MARK: - close

    var closeAnimatedCompletionCallsCount = 0
    var closeAnimatedCompletionCalled: Bool {
        return closeAnimatedCompletionCallsCount > 0
    }
    var closeAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var closeAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var closeAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func close(animated: Bool, completion: (() -> Void)?) {
        closeAnimatedCompletionCallsCount += 1
        closeAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        closeAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        closeAnimatedCompletionClosure?(animated, completion)
    }

    //MARK: - closeAndFinish

    var closeAndFinishAnimatedCompletionCallsCount = 0
    var closeAndFinishAnimatedCompletionCalled: Bool {
        return closeAndFinishAnimatedCompletionCallsCount > 0
    }
    var closeAndFinishAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var closeAndFinishAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var closeAndFinishAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func closeAndFinish(animated: Bool, completion: (() -> Void)?) {
        closeAndFinishAnimatedCompletionCallsCount += 1
        closeAndFinishAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        closeAndFinishAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        closeAndFinishAnimatedCompletionClosure?(animated, completion)
    }

    //MARK: - removeFromParent

    var removeFromParentCallsCount = 0
    var removeFromParentCalled: Bool {
        return removeFromParentCallsCount > 0
    }
    var removeFromParentClosure: (() -> Void)?

    func removeFromParent() {
        removeFromParentCallsCount += 1
        removeFromParentClosure?()
    }

    //MARK: - popToSelf

    var popToSelfAnimatedCompletionCallsCount = 0
    var popToSelfAnimatedCompletionCalled: Bool {
        return popToSelfAnimatedCompletionCallsCount > 0
    }
    var popToSelfAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var popToSelfAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var popToSelfAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func popToSelf(animated: Bool, completion: (() -> Void)?) {
        popToSelfAnimatedCompletionCallsCount += 1
        popToSelfAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        popToSelfAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        popToSelfAnimatedCompletionClosure?(animated, completion)
    }

    //MARK: - dismissRootModalCoordinator

    var dismissRootModalCoordinatorAnimatedCompletionCallsCount = 0
    var dismissRootModalCoordinatorAnimatedCompletionCalled: Bool {
        return dismissRootModalCoordinatorAnimatedCompletionCallsCount > 0
    }
    var dismissRootModalCoordinatorAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var dismissRootModalCoordinatorAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func dismissRootModalCoordinator(animated: Bool, completion: (() -> Void)?) {
        dismissRootModalCoordinatorAnimatedCompletionCallsCount += 1
        dismissRootModalCoordinatorAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        dismissRootModalCoordinatorAnimatedCompletionClosure?(animated, completion)
    }

    //MARK: - isReadyToHandleRoutes

    var isReadyToHandleRoutesCallsCount = 0
    var isReadyToHandleRoutesCalled: Bool {
        return isReadyToHandleRoutesCallsCount > 0
    }
    var isReadyToHandleRoutesReturnValue: Bool!
    var isReadyToHandleRoutesClosure: (() -> Bool)?

    func isReadyToHandleRoutes() -> Bool {
        isReadyToHandleRoutesCallsCount += 1
        return isReadyToHandleRoutesClosure.map({ $0() }) ?? isReadyToHandleRoutesReturnValue
    }

    //MARK: - canHandleRoute

    var canHandleRouteCallsCount = 0
    var canHandleRouteCalled: Bool {
        return canHandleRouteCallsCount > 0
    }
    var canHandleRouteReceivedRoute: Route?
    var canHandleRouteReceivedInvocations: [Route] = []
    var canHandleRouteReturnValue: Bool!
    var canHandleRouteClosure: ((Route) -> Bool)?

    func canHandleRoute(_ route: Route) -> Bool {
        canHandleRouteCallsCount += 1
        canHandleRouteReceivedRoute = route
        canHandleRouteReceivedInvocations.append(route)
        return canHandleRouteClosure.map({ $0(route) }) ?? canHandleRouteReturnValue
    }

    //MARK: - handleRoute

    var handleRouteNavigationStackAnimatedCallsCount = 0
    var handleRouteNavigationStackAnimatedCalled: Bool {
        return handleRouteNavigationStackAnimatedCallsCount > 0
    }
    var handleRouteNavigationStackAnimatedReceivedArguments: (route: Route, navigationStack: [UIViewController], animated: Bool)?
    var handleRouteNavigationStackAnimatedReceivedInvocations: [(route: Route, navigationStack: [UIViewController], animated: Bool)] = []
    var handleRouteNavigationStackAnimatedReturnValue: Bool!
    var handleRouteNavigationStackAnimatedClosure: ((Route, [UIViewController], Bool) -> Bool)?

    func handleRoute(_ route: Route, navigationStack: [UIViewController], animated: Bool) -> Bool {
        handleRouteNavigationStackAnimatedCallsCount += 1
        handleRouteNavigationStackAnimatedReceivedArguments = (route: route, navigationStack: navigationStack, animated: animated)
        handleRouteNavigationStackAnimatedReceivedInvocations.append((route: route, navigationStack: navigationStack, animated: animated))
        return handleRouteNavigationStackAnimatedClosure.map({ $0(route, navigationStack, animated) }) ?? handleRouteNavigationStackAnimatedReturnValue
    }

}
class NavigationControllerViewControllersDelegateMock: NavigationControllerViewControllersDelegate, AutoLenses {

    //MARK: - navigationControllerDidChangeViewControllers

    var navigationControllerDidChangeViewControllersCallsCount = 0
    var navigationControllerDidChangeViewControllersCalled: Bool {
        return navigationControllerDidChangeViewControllersCallsCount > 0
    }
    var navigationControllerDidChangeViewControllersReceivedNavigationController: NavigationController?
    var navigationControllerDidChangeViewControllersReceivedInvocations: [NavigationController] = []
    var navigationControllerDidChangeViewControllersClosure: ((NavigationController) -> Void)?

    func navigationControllerDidChangeViewControllers(_ navigationController: NavigationController) {
        navigationControllerDidChangeViewControllersCallsCount += 1
        navigationControllerDidChangeViewControllersReceivedNavigationController = navigationController
        navigationControllerDidChangeViewControllersReceivedInvocations.append(navigationController)
        navigationControllerDidChangeViewControllersClosure?(navigationController)
    }

}
class NetworkServiceMock: NetworkService, AutoLenses {

    //MARK: - fetchRepositories

    var fetchRepositoriesThrowableError: Error?
    var fetchRepositoriesCallsCount = 0
    var fetchRepositoriesCalled: Bool {
        return fetchRepositoriesCallsCount > 0
    }
    var fetchRepositoriesReturnValue: [Repository]!
    var fetchRepositoriesClosure: (() throws -> [Repository])?

    func fetchRepositories() throws -> [Repository] {
        if let error = fetchRepositoriesThrowableError {
            throw error
        }
        fetchRepositoriesCallsCount += 1
        return try fetchRepositoriesClosure.map({ try $0() }) ?? fetchRepositoriesReturnValue
    }

}
class RepositoryListCoordinatorMock: RepositoryListCoordinator, AutoLenses {
    var viewController: ViewController {
        get { return underlyingViewController }
        set(value) { underlyingViewController = value }
    }
    var underlyingViewController: ViewController!
    var navigationController: NavigationController?
    var rootViewController: UIViewController?

    //MARK: - haveAnyChildren

    var haveAnyChildrenCallsCount = 0
    var haveAnyChildrenCalled: Bool {
        return haveAnyChildrenCallsCount > 0
    }
    var haveAnyChildrenReturnValue: Bool!
    var haveAnyChildrenClosure: (() -> Bool)?

    func haveAnyChildren() -> Bool {
        haveAnyChildrenCallsCount += 1
        return haveAnyChildrenClosure.map({ $0() }) ?? haveAnyChildrenReturnValue
    }

    //MARK: - addChild

    var addChildCallsCount = 0
    var addChildCalled: Bool {
        return addChildCallsCount > 0
    }
    var addChildReceivedCoordinator: Coordinator?
    var addChildReceivedInvocations: [Coordinator] = []
    var addChildClosure: ((Coordinator) -> Void)?

    func addChild(_ coordinator: Coordinator) {
        addChildCallsCount += 1
        addChildReceivedCoordinator = coordinator
        addChildReceivedInvocations.append(coordinator)
        addChildClosure?(coordinator)
    }

    //MARK: - childDidFinish

    var childDidFinishCallsCount = 0
    var childDidFinishCalled: Bool {
        return childDidFinishCallsCount > 0
    }
    var childDidFinishReceivedCoordinator: Coordinator?
    var childDidFinishReceivedInvocations: [Coordinator] = []
    var childDidFinishClosure: ((Coordinator) -> Void)?

    func childDidFinish(_ coordinator: Coordinator) {
        childDidFinishCallsCount += 1
        childDidFinishReceivedCoordinator = coordinator
        childDidFinishReceivedInvocations.append(coordinator)
        childDidFinishClosure?(coordinator)
    }

    //MARK: - set

    var setNavigationControllerCallsCount = 0
    var setNavigationControllerCalled: Bool {
        return setNavigationControllerCallsCount > 0
    }
    var setNavigationControllerReceivedNavigationController: NavigationController?
    var setNavigationControllerReceivedInvocations: [NavigationController?] = []
    var setNavigationControllerClosure: ((NavigationController?) -> Void)?

    func set(navigationController: NavigationController?) {
        setNavigationControllerCallsCount += 1
        setNavigationControllerReceivedNavigationController = navigationController
        setNavigationControllerReceivedInvocations.append(navigationController)
        setNavigationControllerClosure?(navigationController)
    }

    //MARK: - start

    var startFromActionCallsCount = 0
    var startFromActionCalled: Bool {
        return startFromActionCallsCount > 0
    }
    var startFromActionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction)?
    var startFromActionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction)] = []
    var startFromActionClosure: ((Coordinator, CoordinatorAction) -> Void)?

    func start(from parentCoordinator: Coordinator, action: CoordinatorAction) {
        startFromActionCallsCount += 1
        startFromActionReceivedArguments = (parentCoordinator: parentCoordinator, action: action)
        startFromActionReceivedInvocations.append((parentCoordinator: parentCoordinator, action: action))
        startFromActionClosure?(parentCoordinator, action)
    }

    //MARK: - start

    var startFromActionCompletionCallsCount = 0
    var startFromActionCompletionCalled: Bool {
        return startFromActionCompletionCallsCount > 0
    }
    var startFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?
    var startFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)] = []
    var startFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?

    func start(from parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?) {
        startFromActionCompletionCallsCount += 1
        startFromActionCompletionReceivedArguments = (parentCoordinator: parentCoordinator, action: action, completion: completion)
        startFromActionCompletionReceivedInvocations.append((parentCoordinator: parentCoordinator, action: action, completion: completion))
        startFromActionCompletionClosure?(parentCoordinator, action, completion)
    }

    //MARK: - addToParentCoordinator

    var addToParentCoordinatorCallsCount = 0
    var addToParentCoordinatorCalled: Bool {
        return addToParentCoordinatorCallsCount > 0
    }
    var addToParentCoordinatorReceivedParentCoordinator: Coordinator?
    var addToParentCoordinatorReceivedInvocations: [Coordinator] = []
    var addToParentCoordinatorClosure: ((Coordinator) -> Void)?

    func addToParentCoordinator(_ parentCoordinator: Coordinator) {
        addToParentCoordinatorCallsCount += 1
        addToParentCoordinatorReceivedParentCoordinator = parentCoordinator
        addToParentCoordinatorReceivedInvocations.append(parentCoordinator)
        addToParentCoordinatorClosure?(parentCoordinator)
    }

    //MARK: - addToViewControllersHierarchy

    var addToViewControllersHierarchyFromActionCompletionCallsCount = 0
    var addToViewControllersHierarchyFromActionCompletionCalled: Bool {
        return addToViewControllersHierarchyFromActionCompletionCallsCount > 0
    }
    var addToViewControllersHierarchyFromActionCompletionReceivedArguments: (parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)?
    var addToViewControllersHierarchyFromActionCompletionReceivedInvocations: [(parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)] = []
    var addToViewControllersHierarchyFromActionCompletionClosure: ((Coordinator, CoordinatorAction, (() -> Void)?) -> Void)?

    func addToViewControllersHierarchy(from parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?) {
        addToViewControllersHierarchyFromActionCompletionCallsCount += 1
        addToViewControllersHierarchyFromActionCompletionReceivedArguments = (parentCoordinator: parentCoordinator, action: action, completion: completion)
        addToViewControllersHierarchyFromActionCompletionReceivedInvocations.append((parentCoordinator: parentCoordinator, action: action, completion: completion))
        addToViewControllersHierarchyFromActionCompletionClosure?(parentCoordinator, action, completion)
    }

    //MARK: - close

    var closeAnimatedCompletionCallsCount = 0
    var closeAnimatedCompletionCalled: Bool {
        return closeAnimatedCompletionCallsCount > 0
    }
    var closeAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var closeAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var closeAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func close(animated: Bool, completion: (() -> Void)?) {
        closeAnimatedCompletionCallsCount += 1
        closeAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        closeAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        closeAnimatedCompletionClosure?(animated, completion)
    }

    //MARK: - closeAndFinish

    var closeAndFinishAnimatedCompletionCallsCount = 0
    var closeAndFinishAnimatedCompletionCalled: Bool {
        return closeAndFinishAnimatedCompletionCallsCount > 0
    }
    var closeAndFinishAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var closeAndFinishAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var closeAndFinishAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func closeAndFinish(animated: Bool, completion: (() -> Void)?) {
        closeAndFinishAnimatedCompletionCallsCount += 1
        closeAndFinishAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        closeAndFinishAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        closeAndFinishAnimatedCompletionClosure?(animated, completion)
    }

    //MARK: - removeFromParent

    var removeFromParentCallsCount = 0
    var removeFromParentCalled: Bool {
        return removeFromParentCallsCount > 0
    }
    var removeFromParentClosure: (() -> Void)?

    func removeFromParent() {
        removeFromParentCallsCount += 1
        removeFromParentClosure?()
    }

    //MARK: - popToSelf

    var popToSelfAnimatedCompletionCallsCount = 0
    var popToSelfAnimatedCompletionCalled: Bool {
        return popToSelfAnimatedCompletionCallsCount > 0
    }
    var popToSelfAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var popToSelfAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var popToSelfAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func popToSelf(animated: Bool, completion: (() -> Void)?) {
        popToSelfAnimatedCompletionCallsCount += 1
        popToSelfAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        popToSelfAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        popToSelfAnimatedCompletionClosure?(animated, completion)
    }

    //MARK: - dismissRootModalCoordinator

    var dismissRootModalCoordinatorAnimatedCompletionCallsCount = 0
    var dismissRootModalCoordinatorAnimatedCompletionCalled: Bool {
        return dismissRootModalCoordinatorAnimatedCompletionCallsCount > 0
    }
    var dismissRootModalCoordinatorAnimatedCompletionReceivedArguments: (animated: Bool, completion: (() -> Void)?)?
    var dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations: [(animated: Bool, completion: (() -> Void)?)] = []
    var dismissRootModalCoordinatorAnimatedCompletionClosure: ((Bool, (() -> Void)?) -> Void)?

    func dismissRootModalCoordinator(animated: Bool, completion: (() -> Void)?) {
        dismissRootModalCoordinatorAnimatedCompletionCallsCount += 1
        dismissRootModalCoordinatorAnimatedCompletionReceivedArguments = (animated: animated, completion: completion)
        dismissRootModalCoordinatorAnimatedCompletionReceivedInvocations.append((animated: animated, completion: completion))
        dismissRootModalCoordinatorAnimatedCompletionClosure?(animated, completion)
    }

}
class RepositoryListViewModelMock: RepositoryListViewModel, AutoLenses {
    var state: CommonViewModelState {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    var underlyingState: CommonViewModelState!
    var onNeedsReload: (() -> Void)?
    var onStateChanged: ((CommonViewModelState) -> Void)?
    var onClose: (() -> Void)?
    var onGoBack: (() -> Void)?
    var screen: AppScreen {
        get { return underlyingScreen }
        set(value) { underlyingScreen = value }
    }
    var underlyingScreen: AppScreen!
    var headerConfiguration: HeaderConfiguration {
        get { return underlyingHeaderConfiguration }
        set(value) { underlyingHeaderConfiguration = value }
    }
    var underlyingHeaderConfiguration: HeaderConfiguration!

    //MARK: - setup

    var setupInTableViewCallsCount = 0
    var setupInTableViewCalled: Bool {
        return setupInTableViewCallsCount > 0
    }
    var setupInTableViewReceivedTableView: UITableView?
    var setupInTableViewReceivedInvocations: [UITableView] = []
    var setupInTableViewClosure: ((UITableView) -> Void)?

    func setup(inTableView tableView: UITableView) {
        setupInTableViewCallsCount += 1
        setupInTableViewReceivedTableView = tableView
        setupInTableViewReceivedInvocations.append(tableView)
        setupInTableViewClosure?(tableView)
    }

    //MARK: - viewDidAppear

    var viewDidAppearCallsCount = 0
    var viewDidAppearCalled: Bool {
        return viewDidAppearCallsCount > 0
    }
    var viewDidAppearClosure: (() -> Void)?

    func viewDidAppear() {
        viewDidAppearCallsCount += 1
        viewDidAppearClosure?()
    }

    //MARK: - canClose

    var canCloseCallsCount = 0
    var canCloseCalled: Bool {
        return canCloseCallsCount > 0
    }
    var canCloseReturnValue: Bool!
    var canCloseClosure: (() -> Bool)?

    func canClose() -> Bool {
        canCloseCallsCount += 1
        return canCloseClosure.map({ $0() }) ?? canCloseReturnValue
    }

    //MARK: - canGoBack

    var canGoBackCallsCount = 0
    var canGoBackCalled: Bool {
        return canGoBackCallsCount > 0
    }
    var canGoBackReturnValue: Bool!
    var canGoBackClosure: (() -> Bool)?

    func canGoBack() -> Bool {
        canGoBackCallsCount += 1
        return canGoBackClosure.map({ $0() }) ?? canGoBackReturnValue
    }

}
class RoutingControllerMock: RoutingController, AutoLenses {
    var mainRouter: MainRouter?
    var hasPendingRoute: Bool {
        get { return underlyingHasPendingRoute }
        set(value) { underlyingHasPendingRoute = value }
    }
    var underlyingHasPendingRoute: Bool!
    var pendingRoute: Route?
    var pendingRouteSource: RouteSource?

    //MARK: - canHandleUrl

    var canHandleUrlCallsCount = 0
    var canHandleUrlCalled: Bool {
        return canHandleUrlCallsCount > 0
    }
    var canHandleUrlReceivedUrl: URL?
    var canHandleUrlReceivedInvocations: [URL] = []
    var canHandleUrlReturnValue: Bool!
    var canHandleUrlClosure: ((URL) -> Bool)?

    func canHandleUrl(_ url: URL) -> Bool {
        canHandleUrlCallsCount += 1
        canHandleUrlReceivedUrl = url
        canHandleUrlReceivedInvocations.append(url)
        return canHandleUrlClosure.map({ $0(url) }) ?? canHandleUrlReturnValue
    }

    //MARK: - handleUrl

    var handleUrlSourceCallsCount = 0
    var handleUrlSourceCalled: Bool {
        return handleUrlSourceCallsCount > 0
    }
    var handleUrlSourceReceivedArguments: (url: URL, source: RouteSource)?
    var handleUrlSourceReceivedInvocations: [(url: URL, source: RouteSource)] = []
    var handleUrlSourceReturnValue: Bool!
    var handleUrlSourceClosure: ((URL, RouteSource) -> Bool)?

    func handleUrl(_ url: URL, source: RouteSource) -> Bool {
        handleUrlSourceCallsCount += 1
        handleUrlSourceReceivedArguments = (url: url, source: source)
        handleUrlSourceReceivedInvocations.append((url: url, source: source))
        return handleUrlSourceClosure.map({ $0(url, source) }) ?? handleUrlSourceReturnValue
    }

    //MARK: - handleRoute

    var handleRouteSourceCallsCount = 0
    var handleRouteSourceCalled: Bool {
        return handleRouteSourceCallsCount > 0
    }
    var handleRouteSourceReceivedArguments: (route: Route, source: RouteSource)?
    var handleRouteSourceReceivedInvocations: [(route: Route, source: RouteSource)] = []
    var handleRouteSourceClosure: ((Route, RouteSource) -> Void)?

    func handleRoute(_ route: Route, source: RouteSource) {
        handleRouteSourceCallsCount += 1
        handleRouteSourceReceivedArguments = (route: route, source: source)
        handleRouteSourceReceivedInvocations.append((route: route, source: source))
        handleRouteSourceClosure?(route, source)
    }

    //MARK: - didEnterBackground

    var didEnterBackgroundCallsCount = 0
    var didEnterBackgroundCalled: Bool {
        return didEnterBackgroundCallsCount > 0
    }
    var didEnterBackgroundClosure: (() -> Void)?

    func didEnterBackground() {
        didEnterBackgroundCallsCount += 1
        didEnterBackgroundClosure?()
    }

    //MARK: - activeCoordinatorChanged

    var activeCoordinatorChangedCallsCount = 0
    var activeCoordinatorChangedCalled: Bool {
        return activeCoordinatorChangedCallsCount > 0
    }
    var activeCoordinatorChangedClosure: (() -> Void)?

    func activeCoordinatorChanged() {
        activeCoordinatorChangedCallsCount += 1
        activeCoordinatorChangedClosure?()
    }

    //MARK: - handleCurrentRoute

    var handleCurrentRouteCallsCount = 0
    var handleCurrentRouteCalled: Bool {
        return handleCurrentRouteCallsCount > 0
    }
    var handleCurrentRouteClosure: (() -> Void)?

    func handleCurrentRoute() {
        handleCurrentRouteCallsCount += 1
        handleCurrentRouteClosure?()
    }

    //MARK: - addObserver

    var addObserverCallsCount = 0
    var addObserverCalled: Bool {
        return addObserverCallsCount > 0
    }
    var addObserverReceivedObserver: RoutingControllerEventObserver?
    var addObserverReceivedInvocations: [RoutingControllerEventObserver] = []
    var addObserverClosure: ((RoutingControllerEventObserver) -> Void)?

    func addObserver(_ observer: RoutingControllerEventObserver) {
        addObserverCallsCount += 1
        addObserverReceivedObserver = observer
        addObserverReceivedInvocations.append(observer)
        addObserverClosure?(observer)
    }

    //MARK: - removeObserver

    var removeObserverCallsCount = 0
    var removeObserverCalled: Bool {
        return removeObserverCallsCount > 0
    }
    var removeObserverReceivedObserverID: UUID?
    var removeObserverReceivedInvocations: [UUID] = []
    var removeObserverClosure: ((UUID) -> Void)?

    func removeObserver(_ observerID: UUID) {
        removeObserverCallsCount += 1
        removeObserverReceivedObserverID = observerID
        removeObserverReceivedInvocations.append(observerID)
        removeObserverClosure?(observerID)
    }

}
