//
//  NavigationController.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

protocol NavigationControllerViewControllersDelegate: AnyObject, AutoMockable {
    func navigationControllerDidChangeViewControllers(_ navigationController: NavigationController)
}

protocol NavigationController: UINavigationController, ViewController {

    var viewControllersDelegate: NavigationControllerViewControllersDelegate? { get set }

    func pushToViewController(
        _ viewController: UIViewController,
        completion: @escaping () -> Void
    )
    func pushToViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void
    )

    func pushVC(
        _ viewController: UIViewController,
        animated: Bool,
        completion: (() -> Void)?
    )
    func pushVC(_ viewController: UIViewController)

    func insertAtBeginning(viewController: UIViewController)
    func insert(viewController: UIViewController, before next: UIViewController)

    func popViewController(completion: @escaping () -> Void)
    func popViewController(animated: Bool, completion: @escaping () -> Void)

    func popToViewController(_ viewController: UIViewController, completion: @escaping () -> Void)
    func popToViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void
    )

    func popToViewController(
        beforeViewController referencedViewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void
    )
    func popToViewController(
        beforeViewController referencedViewController: UIViewController,
        completion: @escaping () -> Void
    )

    func popToRootViewController(animated: Bool, completion: @escaping () -> Void)
    func popToRootViewController(completion: @escaping () -> Void)

    func removeAllViewControllers(
        before firstViewControllerToLeave: UIViewController,
        except: UIViewController?
    )
    func removeAllViewControllers(before firstViewControllerToLeave: UIViewController)
    func removeOneViewController(before reference: UIViewController)

    func popVC(animated: Bool, completion: (() -> Void)?)
    func popVC(completion: (() -> Void)?)
    func popVC(animated: Bool)
    func popVC()

    func removeVC(_ viewController: UIViewController)

    func pushViewController(_ viewController: UIViewController, animated: Bool)

    func dismissAndPopToRoot()
}

class NavigationControllerImpl: UINavigationController, NavigationController {

    weak var viewControllersDelegate: NavigationControllerViewControllersDelegate?

    override open var childForStatusBarStyle: UIViewController? {
        topViewController
    }

    convenience init(rootViewController: UIViewController, delegate: AnyObject, navigationBarHidden: Bool = true) {
        self.init(rootViewController: rootViewController)

        if let delegate = delegate as? UINavigationControllerDelegate {
            self.delegate = delegate
        }

        if let delegate = delegate as? NavigationControllerViewControllersDelegate {
            self.viewControllersDelegate = delegate
        }

        if let delegate = delegate as? UIGestureRecognizerDelegate {
            interactivePopGestureRecognizer?.delegate = delegate
        }

        setNavigationBarHidden(navigationBarHidden, animated: false)
    }

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool = AppUI.animationsEnabled) {

        let currentTopController = topViewController
        let viewControllersToSet = viewControllers.removeDuplicates()

        assert(viewControllers.count == viewControllersToSet.count, "ViewControllers to set had duplicates")

        super.setViewControllers(viewControllersToSet, animated: animated)

        // If top controller changes, navigationController's delegate didShowViewController will be called so we will handle cleanup there.
        guard viewControllers.last === currentTopController else { return }

        viewControllersDelegate?.navigationControllerDidChangeViewControllers(self)
    }

    func dismiss(animated: Bool = AppUI.animationsEnabled) {
        dismiss(animated: animated, completion: nil)
    }

    func dismissAndPopToRoot() {
        dismiss(animated: false)
        popToRootViewController(animated: false)
    }

    func present(_ controller: UIViewController, animated: Bool = AppUI.animationsEnabled) {
        present(controller, animated: animated, completion: nil)
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default, handler: nil))
        present(alert, animated: AppUI.animationsEnabled)
    }

    func pushToViewController(_ viewController: UIViewController, animated: Bool = AppUI.animationsEnabled, completion: @escaping () -> Void) {

        guard animated, isLoadedAndHasWindow else {
            pushViewController(viewController, animated: false)
            completion()
            return
        }

        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }

    func pushToViewController(_ viewController: UIViewController, completion: @escaping () -> Void) {
        pushToViewController(viewController, animated: AppUI.animationsEnabled, completion: completion)
    }

    func popViewController(animated: Bool = AppUI.animationsEnabled, completion: @escaping () -> Void) {

        guard animated, isLoadedAndHasWindow else {
            popViewController(animated: false)
            completion()
            return
        }

        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: AppUI.animationsEnabled)
        CATransaction.commit()
    }

    func popViewController(completion: @escaping () -> Void) {
        popViewController(animated: AppUI.animationsEnabled, completion: completion)
    }

    func popToViewController(_ viewController: UIViewController, animated: Bool = AppUI.animationsEnabled, completion: @escaping () -> Void) {

        guard animated, isLoadedAndHasWindow else {
            popToViewController(viewController, animated: false)
            completion()
            return
        }

        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToViewController(viewController, animated: animated)
        CATransaction.commit()
    }

    func popToViewController(_ viewController: UIViewController, completion: @escaping () -> Void) {
        popToViewController(viewController, animated: AppUI.animationsEnabled, completion: completion)
    }

    func popToViewController(
        beforeViewController referencedViewController: UIViewController,
        animated: Bool = AppUI.animationsEnabled,
        completion: @escaping () -> Void
    ) {
        guard let index = viewControllers.firstIndex(of: referencedViewController)
        else {
            popViewController(animated: animated, completion: completion)
            return
        }
        let previous = viewControllers[index - 1]
        popToViewController(previous, animated: animated, completion: completion)
    }

    func popToViewController(
        beforeViewController referencedViewController: UIViewController,
        completion: @escaping () -> Void
    ) {
        popToViewController(
            beforeViewController: referencedViewController,
            animated: AppUI.animationsEnabled,
            completion: completion
        )
    }

    func popToRootViewController(animated: Bool = AppUI.animationsEnabled, completion: @escaping () -> Void) {

        guard animated, isLoadedAndHasWindow else {
            popToRootViewController(animated: false)
            completion()
            return
        }

        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }

    func popToRootViewController(completion: @escaping () -> Void) {
        popToRootViewController(animated: AppUI.animationsEnabled, completion: completion)
    }

    func removeAllViewControllers(before firstViewControllerToLeave: UIViewController, except: UIViewController?) {
        var found = false
        let reducedViewControllers = viewControllers.filter { viewController in
            guard found == false else { return true }
            if viewController === firstViewControllerToLeave {
                found = true
                return true
            } else if viewController === except {
                return true
            }

            return false
        }

        guard found else {
            return
        }

        guard reducedViewControllers.hasElements else {
            return
        }
        setViewControllers(reducedViewControllers, animated: false)
    }

    func removeAllViewControllers(before firstViewControllerToLeave: UIViewController) {
        removeAllViewControllers(before: firstViewControllerToLeave, except: nil)
    }

    func removeOneViewController(before reference: UIViewController) {
        guard let index = viewControllers.firstIndex(of: reference) else {
            return
        }

        guard index > 0 else {
            return
        }

        var reducedViewControllers = viewControllers
        reducedViewControllers.remove(at: index - 1)
        setViewControllers(reducedViewControllers, animated: false)
    }

    // MARK: - Transitions

    /*
     Pushes view controller with specific transitionType.
     */
    private func pushVC(
        _ viewController: UIViewController,
        animated: Bool = AppUI.animationsEnabled,
        transitionType: CATransitionType?,
        animationTime: TimeInterval? = nil,
        completion: (() -> Void)? = nil
    ) {

        guard animated, isLoadedAndHasWindow else {
            pushViewController(viewController, animated: false)
            completion?()
            return
        }

        if let completion {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
        }

        if let transitionType {
            let transition = CATransition()
            transition.duration = animationTime ?? TimeInterval(0.3)
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = transitionType
            view.layer.add(transition, forKey: nil)
            pushViewController(viewController, animated: false)
        } else {
            pushViewController(viewController, animated: animated)
        }

        if completion != nil {
            CATransaction.commit()
        }
    }

    /*
     Pop view controller with specific transitionType.
     */
    private func popVC(
        animated: Bool = AppUI.animationsEnabled,
        transitionType: CATransitionType?,
        animationTime: TimeInterval? = nil,
        completion: (() -> Void)? = nil
    ) {

        guard animated, isLoadedAndHasWindow else {
            popViewController(animated: false)
            completion?()
            return
        }

        if let completion {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
        }

        if let transitionType {
            let transition = CATransition()
            transition.duration = animationTime ?? TimeInterval(0.3)
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = transitionType
            view.layer.add(transition, forKey: nil)
            popViewController(animated: false)
        } else {
            popViewController(animated: animated)
        }

        if completion != nil {
            CATransaction.commit()
        }
    }

    /*
     Push view controller with completion, but use custom transition, if set on new/replaced VC.
     If any viewcontroller new or replaced has HasTransition set, this transition will be executed.
     */
    func pushVC(_ viewController: UIViewController, animated: Bool = AppUI.animationsEnabled, completion: (() -> Void)?) {
        var transitionType: CATransitionType?
        var animationTime: TimeInterval?
        let currentVC = viewControllers.last

        if let VCWithTransition = viewController as? HasTransition,
           let type = VCWithTransition.transitionTo(wasShownVC: currentVC) {
            transitionType = type
            animationTime = VCWithTransition.transitionTime()
        } else if let VCWithTransition = currentVC as? HasTransition,
                  let type = VCWithTransition.transitionFrom(willShowVC: viewController) {
            transitionType = type
            animationTime = VCWithTransition.transitionTime()
        }
        pushVC(viewController, animated: animated, transitionType: transitionType, animationTime: animationTime, completion: completion)
    }

    func pushVC(_ viewController: UIViewController) {
        pushVC(viewController, animated: AppUI.animationsEnabled, completion: nil)
    }

    func popVC(animated: Bool = AppUI.animationsEnabled, completion: (() -> Void)?) {
        guard let currentVC = viewControllers.last else { return }
        let previousVC = viewControllers[viewControllers.count - 2]

        var transitionType: CATransitionType?
        var animationTime: TimeInterval?

        if let VCWithTransition = currentVC as? HasTransition,
           let type = VCWithTransition.transitionBackFrom(willShowVC: previousVC) {
            transitionType = type
            animationTime = VCWithTransition.transitionTime()
        } else if let VCWithTransition = previousVC as? HasTransition,
                  let type = VCWithTransition.transitionBackTo(wasShownVC: currentVC) {
            transitionType = type
            animationTime = VCWithTransition.transitionTime()
        }

        popVC(animated: animated, transitionType: transitionType, animationTime: animationTime, completion: completion)
    }

    func popVC(animated: Bool = AppUI.animationsEnabled) {
        popVC(animated: animated, completion: nil)
    }

    func popVC(completion: (() -> Void)?) {
        popVC(animated: AppUI.animationsEnabled, completion: completion)
    }

    func popVC() {
        popVC(animated: AppUI.animationsEnabled, completion: nil)
    }

    func insertAtBeginning(viewController: UIViewController) {
        var updatedViewControllers = viewControllers
        updatedViewControllers.insert(viewController, at: 0)
        setViewControllers(updatedViewControllers, animated: false)
    }

    func insert(viewController: UIViewController, before next: UIViewController) {
        var updatedViewControllers = viewControllers
        if let index = viewControllers.firstIndex(of: next) {
            updatedViewControllers.insert(viewController, at: index)
        } else {
            updatedViewControllers.insert(viewController, at: 0)
        }
        setViewControllers(updatedViewControllers, animated: false)
    }

    func removeVC(_ viewController: UIViewController) {
        var found = false
        let reducedViewControllers = viewControllers.filter { filteredViewController in
            if filteredViewController === viewController {
                found = true
                return false
            }
            return true
        }
        guard found else {
            return
        }
        guard reducedViewControllers.hasElements else {
            return
        }
        setViewControllers(reducedViewControllers, animated: false)
    }
}
