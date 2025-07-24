//
//  MainRoutingViewController.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

/// This is always the base view controller on app launch
/// Handles any routing between states
protocol MainRoutingViewController: UIViewController, AutoFactory {
    var viewController: UIViewController? { get }
    func show(viewController: UIViewController)
}

class MainRoutingViewControllerImpl: UIViewController, MainRoutingViewController {

    override var childForStatusBarStyle: UIViewController? {
        viewController
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private(set) var viewController: UIViewController? {
        willSet {
            guard let viewController else { return }

            dismiss(animated: false, completion: nil)
            viewController.dismiss(animated: false, completion: nil)
            remove(childViewController: viewController)
        }
        didSet {
            guard let viewController else { return }
            add(childViewController: viewController)
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    func show(viewController: UIViewController) {
        self.viewController = viewController
    }
}
