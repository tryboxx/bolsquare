//
//  ViewController.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit

protocol ViewController: UIViewController {

    var presentedViewController: UIViewController? { get }
    var modalPresentationStyle: UIModalPresentationStyle { get set }

    func dismiss(animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool)

    func present(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?)
    func present(_ controller: UIViewController, animated: Bool)

    func showErrorAlert(message: String)

    func isModal() -> Bool
}

class ViewControllerImpl: UIViewController, ViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let self = self as? HasAppScreen {
            return self.screen.statusBarStyle
        }

        return .darkContent
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        if let self = self as? ViewController & HasAppScreen {
            self.hidesBottomBarWhenPushed = self.screen.hidesTabBar
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        stopLoading()
    }

    func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }

    func present(_ controller: UIViewController, animated: Bool) {
        present(controller, animated: animated, completion: nil)
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default, handler: nil))
        present(alert, animated: AppUI.animationsEnabled)
    }
}

extension UIViewController {

    func isModal() -> Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
