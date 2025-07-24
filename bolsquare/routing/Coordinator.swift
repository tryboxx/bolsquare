//
//  Coordinator.swift
//  BolSquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit

enum CoordinatorAction {
    case none(navController: NavigationController? = nil)
    case push(animated: Bool = AppUI.animationsEnabled, navController: NavigationController? = nil)
    case show(animated: Bool = AppUI.animationsEnabled, viewController: ViewController? = nil)
}

@MainActor
protocol Coordinator: AnyObject, AutoMockable {
    var viewController: ViewController { get }
    var navigationController: NavigationController? { get }
    var rootViewController: UIViewController? { get }

    func haveAnyChildren() -> Bool
    func addChild(_ coordinator: Coordinator)
    func childDidFinish(_ coordinator: Coordinator)

    func set(navigationController: NavigationController?)

    func start(from parentCoordinator: Coordinator, action: CoordinatorAction)
    func start(from parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)?)

    func addToParentCoordinator(_ parentCoordinator: Coordinator)
    func addToViewControllersHierarchy(
        from parentCoordinator: Coordinator,
        action: CoordinatorAction,
        completion: (() -> Void)?
    )

    func close(animated: Bool, completion: (() -> Void)?)
    func closeAndFinish(animated: Bool, completion: (() -> Void)?)
    func removeFromParent()
    func popToSelf(animated: Bool, completion: (() -> Void)?)
    func dismissRootModalCoordinator(animated: Bool, completion: (() -> Void)?)
}

@MainActor
protocol CanBlockClosingViewController {
    func canCollapseViewControllersHierarchy() -> Bool
}

@MainActor
protocol CanScrollToTop {
    func canScrollToTop() -> Bool
    func scrollToTop(animated: Bool)
}

extension CanScrollToTop {
    func canScrollToTop() -> Bool {
        true
    }
}

@MainActor
protocol RootClosable where Self: Coordinator {
    var onRequestRootToClose: (() -> Void)? { get set }

    func closeOrRequestRootToClose()
}

extension RootClosable {

    func closeOrRequestRootToClose() {
        guard onRequestRootToClose == nil else {
            onRequestRootToClose?()
            return
        }

        closeAndFinish(animated: true, completion: nil)
    }
}

class CoordinatorImpl: NSObject, Coordinator {
    var viewController: ViewController {
        fatalError("Coordinator viewController not implemented!")
    }

    var navigationController: NavigationController?

    static var rootModalCoordinator: Coordinator?

    var rootViewController: UIViewController? {
        if viewController is UINavigationController {
            return navigationController?.viewControllers.first
        } else {
            return viewController
        }
    }

    var children = [Coordinator]()
    private weak var parent: Coordinator?

    func haveAnyChildren() -> Bool {
        !children.isEmpty
    }

    func addChild(_ coordinator: Coordinator) {
        children.append(coordinator)
    }

    func childDidFinish(_ coordinator: Coordinator) {
        guard let index = (children.firstIndex { $0 === coordinator }) else { return  }

        if CoordinatorImpl.rootModalCoordinator === coordinator {
            CoordinatorImpl.rootModalCoordinator = self
        }

        children.remove(at: index)
    }

    func set(navigationController: NavigationController?) {
        self.navigationController = navigationController
    }

    func start(from parentCoordinator: Coordinator, action: CoordinatorAction) {
        start(from: parentCoordinator, action: action, completion: nil)
    }

    func start(from parentCoordinator: Coordinator, action: CoordinatorAction, completion: (() -> Void)? = nil) {

        addToParentCoordinator(parentCoordinator)
        addToViewControllersHierarchy(from: parentCoordinator, action: action, completion: completion)
    }

    func addToParentCoordinator(_ parentCoordinator: Coordinator) {
        parentCoordinator.addChild(self)
        parent = parentCoordinator
    }

    func addToViewControllersHierarchy(
        from parentCoordinator: Coordinator,
        action: CoordinatorAction,
        completion: (() -> Void)?
    ) {
        switch action {
        case .none(let navigationController):
            let parentNavigationController = navigationController ?? parentCoordinator.navigationController
            set(navigationController: parentNavigationController)
            completion?()
        case .push(let animated, let navigationController):
            push(from: parentCoordinator, in: navigationController, animated: animated, completion: completion)
        case .show(let animated, let viewController):
            if CoordinatorImpl.rootModalCoordinator == nil {
                CoordinatorImpl.rootModalCoordinator = self
            }
            show(from: parentCoordinator, on: viewController, animated: animated, completion: completion)
        }
    }

    func close(animated: Bool = AppUI.animationsEnabled, completion: (() -> Void)? = nil) {
        if isModalPresentation() { // modal
            if CoordinatorImpl.rootModalCoordinator === self {
                CoordinatorImpl.rootModalCoordinator = nil
            }

            viewController.dismiss(animated: animated) {
                completion?()
            }
        } else { // push
            navigationController?.popToViewController(beforeViewController: viewController, animated: animated, completion: {
                completion?()
            })
        }
    }

    func closeAndFinish(animated: Bool = AppUI.animationsEnabled, completion: (() -> Void)? = nil) {
        if isModalPresentation() { // modal
            /// If current viewController is presenting any other view controller
            /// calling just viewController.dismiss would only close this VC on top
            /// which this code here must close my current VC
            /// hence we should close from VC that presented current VC.

            if CoordinatorImpl.rootModalCoordinator === self {
                CoordinatorImpl.rootModalCoordinator = nil
            }

            let presentingViewController = viewController.presentingViewController ?? viewController
            presentingViewController.dismiss(animated: animated) { [weak self] in
                guard let self else { return }
                completion?()
                self.removeFromParent()
            }
        } else { // push
            navigationController?.popToViewController(beforeViewController: viewController, animated: animated, completion: { [weak self] in
                guard let self else { return }
                completion?()
                self.removeFromParent()
            })
        }
    }

    func dismissRootModalCoordinator(
        animated: Bool = AppUI.animationsEnabled,
        completion: (() -> Void)? = nil
    ) {
        guard let coordinator = CoordinatorImpl.rootModalCoordinator else {
            return
        }
        CoordinatorImpl.rootModalCoordinator = nil
        coordinator.closeAndFinish(animated: true, completion: nil)
    }

    func removeFromParent() {
        parent?.childDidFinish(self)
    }

    func popToSelf(animated: Bool = AppUI.animationsEnabled, completion: (() -> Void)? = nil) {
        navigationController?.popToViewController(viewController, animated: animated, completion: {
            completion?()
        })
    }

    func canCollapseViewControllersHierarchy() -> Bool {
//        guard let navigationController,
//              navigationController.viewControllers.count > 1 else {
//            return false
//        }
//
//        guard !children.isEmpty else { return true }
//
//        return children.allSatisfy { $0.canCollapseViewControllersHierarchy() }
        true
    }

    // Finds all coordinator across self and childrens, whos view controller is not within navigation stack and finish them.
    func finishFreeChildren() {
//        children.forEach { $0.finishFreeChildren() }
//
//        guard let navigationController else {
//            return
//        }
//
//        children
//            .filter {
//                // we do not want to finish a modally presented childrens
//                $0.isModalPresentation() == false
//            }
//            .filter {
//                // if coordinator have active children
//                // (and we know it's active, because we ran finishFreeChildren on all children at the beginning of this method),
//                // it means we are in the middle of navigation stack, so we can't free this coordinator, as it's child depends on it
//                $0.haveAnyChildren() == false
//            }
//            .filter {
//                navigationController.viewControllers.doesNotContain($0.viewController)
//            }
//            .forEach {
//                childDidFinish($0)
//            }
    }

    func isModalPresentation() -> Bool {
        navigationController == nil || navigationController === viewController
    }

    func dismissedByTappingOutside() {}
}

extension CoordinatorImpl {

    private func push(
        from parentCoordinator: Coordinator,
        in navigationController: NavigationController?,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        guard let parentNavigationController = navigationController ?? parentCoordinator.navigationController else {
            return
        }

        self.navigationController = parentNavigationController
        parentNavigationController.pushVC(viewController, animated: animated, completion: completion)
    }

    private func show(
        from parentCoordinator: Coordinator,
        on viewController: ViewController?,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        let parentViewController = viewController ?? parentCoordinator.navigationController ?? parentCoordinator.viewController
        parentViewController.modalPresentationCapturesStatusBarAppearance = true

        guard parentViewController.presentedViewController != self.viewController else {
            return
        }

        self.viewController.presentationController?.delegate = self

        parentViewController.present(self.viewController, animated: animated, completion: completion)
    }
}

// MARK: Release coordinators via navigationController delegate
extension CoordinatorImpl: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // Since we are here, it means pop happened.
        finishFreeChildren()
    }
}

extension CoordinatorImpl: NavigationControllerViewControllersDelegate {
    func navigationControllerDidChangeViewControllers(_ navigationController: NavigationController) {
        finishFreeChildren()
    }
}

// MARK: Support for interactive back gesture
extension CoordinatorImpl: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController,
              gestureRecognizer == navigationController.interactivePopGestureRecognizer else { return true }
        guard navigationController.viewControllers.count > 1 else { return false }

        return canCollapseViewControllersHierarchy()
    }
}

// MARK: Support for Scroll To Top on TabBar tap.
extension CoordinatorImpl: CanScrollToTop {

    func canScrollToTop() -> Bool {
        guard let navigationController,
              canCollapseViewControllersHierarchy() == false,
              let viewController = navigationController.topViewController as? CanScrollToTop else { return false }

        return viewController.canScrollToTop()
    }

    func scrollToTop(animated: Bool) {
        guard let navigationController,
              let viewController = navigationController.topViewController as? CanScrollToTop else { return }

        viewController.scrollToTop(animated: animated)
    }
}

extension CoordinatorImpl: UIAdaptivePresentationControllerDelegate {

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        dismissedByTappingOutside()
        removeFromParent()
    }
}
