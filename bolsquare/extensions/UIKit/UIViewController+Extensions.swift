//
//  UIViewController+Extensions.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit
import MBProgressHUD

private var loadingStackKey = "LoadingStackKey"

struct ActionSheet {
    let title: String
    let action: () -> Void
}

extension UIViewController {

    /// Adds a child view controller and call the necessary methods
    func add(childViewController viewController: UIViewController, frame: CGRect? = nil) {
        addChild(viewController)
        if let frame {
            viewController.view.frame = frame
        } else {
            viewController.view.frame = view.bounds
        }
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }

    /// Removes the child view controller with all necessary methods
    func remove(childViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

extension UIViewController {

    func addChildren(viewControllers: [UIViewController]) {
        viewControllers.forEach { [weak self] in
            self?.addChild($0)
            $0.view.translatesAutoresizingMaskIntoConstraints = false
            $0.didMove(toParent: self)
        }
    }

    func removeChildren() {
        for child in children {
            child.didMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}

extension UIViewController {

    func showAlert(title: String?, message: String?, callback: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                                        callback()
            }
        ))
        present(alert, animated: AppUI.animationsEnabled, completion: nil)
    }

    func showAlert(
        title: String?,
        message: String?,
        confirmText: String,
        confirmStyle: UIAlertAction.Style = .default,
        cancelText: String,
        callback: @escaping () -> Void,
        cancelCallback: (() -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        let confirmAction = UIAlertAction(
            title: confirmText,
            style: confirmStyle,
            handler: { _ in callback() }
        )

        let cancelAction = UIAlertAction(
            title: cancelText,
            style: .cancel,
            handler: { _ in cancelCallback?() }
        )

        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        alert.preferredAction = confirmAction
        present(alert, animated: AppUI.animationsEnabled, completion: completion)
    }

    func showAlert(
        title: String?,
        message: String?,
        alertActions: [UIAlertAction]
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alertActions.forEach { alert.addAction($0) }

        present(alert, animated: AppUI.animationsEnabled, completion: nil)
    }
}

extension UIViewController {
    /// call this function to dismiss keyboard by tapping anywhere on the view controller
    func setupHideKeyboardOnTap(cancelsTouchesInView: Bool = false) {
        view
            .addGestureRecognizer(endEditingRecognizer(cancelsTouchesInView: cancelsTouchesInView))
        navigationController?.navigationBar
            .addGestureRecognizer(endEditingRecognizer(cancelsTouchesInView: cancelsTouchesInView))
    }

    private func endEditingRecognizer(cancelsTouchesInView: Bool) -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = cancelsTouchesInView
        return tap
    }
}

extension UIViewController {

    func startLoading(progressLabel: String? = L10n.Common.loading) {

        guard let window = view.window else {
            return
        }

        window.addToLoadingStack(self)

        if let currentHUD = MBProgressHUD.forView(window) {
            currentHUD.hide(animated: false)
        }

        let progressHUD = MBProgressHUD.showLoading(addedTo: window, animated: AppUI.animationsEnabled)
        progressHUD.customProgressView?.title = progressLabel ?? L10n.Common.loading
    }

    func stopLoading(isAnimated: Bool = true) {

        guard let window = view.window else {
            return
        }

        window.removeFromLoadingStack(self)

        guard let loadingStack = window.loadingStack, loadingStack.isEmpty else { return }

        MBProgressHUD.hide(for: window, animated: isAnimated)
    }
}

extension UIViewController {
    func hideNavigationBar(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func showNavigationBar(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension UINavigationController {
    func getPreviousViewController() -> UIViewController? {
        let count = viewControllers.count
        guard count > 1 else { return nil }
        return viewControllers[count - 2]
    }
}

extension UIViewController {
    func topMostViewController() -> UIViewController {

        if let presented = presentedViewController {
            return presented.topMostViewController()
        }

        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }

        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }

        return self
    }

    var isLoadedAndHasWindow: Bool {
        isViewLoaded && view.window != nil
    }

    func printMeAndChildren(prefix: String = "") {
        /// Add logs printing
    }
}

extension UIApplication {
    func mainWindow() -> UIWindow? {
        connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }
    }

    func topMostViewController() -> UIViewController? {
        mainWindow()?.rootViewController?.topMostViewController()
    }
}

extension UIViewController {
    func find<T: UIViewController>(childOfType childType: T.Type) -> T? {
        children.first { $0 is T } as? T
    }
}

private extension UIWindow {
    var loadingStack: [UIViewController]? {
        withUnsafePointer(to: &loadingStackKey) {
            objc_getAssociatedObject(self, $0) as? [UIViewController]
        }
    }

    func addToLoadingStack(_ viewController: UIViewController) {
        var loadingStack: [UIViewController] = loadingStack ?? []
        loadingStack.removeAll(where: { $0 === viewController })
        loadingStack.append(viewController)
        withUnsafePointer(to: &loadingStackKey) {
            objc_setAssociatedObject(self, $0, loadingStack, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func removeFromLoadingStack(_ viewController: UIViewController) {
        var loadingStack: [UIViewController] = loadingStack ?? []
        loadingStack.removeAll(where: { $0 === viewController })
        withUnsafePointer(to: &loadingStackKey) {
            objc_setAssociatedObject(self, $0, loadingStack, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension UIViewController {
    func dismissKeyboard() {
        view.dismissKeyboard()
    }
}

extension [UIViewController] {
    func removeDuplicates() -> [UIViewController] {
        var result = [UIViewController]()
        for viewController in self.reversed() {
            guard result.contains(viewController) == false else { continue }
            result.insert(viewController, at: 0)
        }
        return result
    }
}
