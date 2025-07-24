//
//  BaseTestCase.swift
//  bolsquareTests
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import XCTest
import Nimble
import Nimble_Snapshots

@testable import bolsquare

enum ScreenshotHeight {
    case full
    case screenHeight
    case custom(CGFloat)

    var customValue: CGFloat? {
        switch self {
        case .custom(let value): return value
        default: return nil
        }
    }
}

@MainActor
class BaseTestCase: XCTestCase {

    func snapshot(_ name: String? = nil, usesDrawRect: Bool = false) -> Snapshot {
        Nimble_Snapshots.snapshot(name, usesDrawRect: usesDrawRect)
    }

    func recordSnapshot(_ name: String? = nil, usesDrawRect: Bool = false) -> Snapshot {
        Nimble_Snapshots.recordSnapshot(name, usesDrawRect: usesDrawRect)
    }

    /// Prepares UIView before snapshot tests
    /// - Parameters:
    ///   - view: designated UIView
    ///   - withHeight: optional parameter
    func prepare(view: UIView, withHeight height: ScreenshotHeight = ScreenshotHeight.full) {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        guard let scrollView = view.findViews(subclassOf: UIScrollView.self).first else {
            view.frame.size = .init(
                width: screenWidth,
                height: height.customValue ?? screenHeight
            )
            view.layoutIfNeeded()
            return
        }

        view.frame = UIScreen.main.bounds
        view.layoutIfNeeded()

        let scrollViewWidth = scrollView.contentSize.width
        let scrollViewContentHeight = scrollView.contentSize.height
            + scrollView.contentInset.top
            + scrollView.contentInset.bottom

        var desiredHeight = screenHeight
        switch height {
        case .screenHeight: break
        case .custom(let value): desiredHeight = value
        case .full: desiredHeight = screenHeight > scrollViewContentHeight ? screenHeight : scrollViewContentHeight
        }

        view.frame.size = .init(
            width: scrollViewWidth,
            height: desiredHeight
        )
    }

    func prepareViewInScreenSize(view: UIView) {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        view.frame.size = .init(
            width: screenWidth,
            height: screenHeight
        )
        view.layoutIfNeeded()
    }

    func embedInWindow(view: UIView, width: CGFloat = 320, padding: CGFloat = 0.0) -> UIView {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        view.sizeToFit(width: width)

        let vbounds = view.bounds

        let container = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: width + 2 * padding,
                height: view.bounds.height + 2 * padding
            )
        )
        container.backgroundColor = .white
        container.addSubview(view)
        view.center = container.center

        let VC = UIViewController()
        VC.view.addSubview(container)

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = VC
        window.makeKeyAndVisible()

        return container
    }

    func putIntoKeyWindow(viewController: UIViewController) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    func embed(view: UIView, inParentWithColor parentColor: UIColor = Colors.neutral50.color) -> UIView {
        let parent = UIView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: view.frame.width + view.frame.origin.x,
                    height: view.frame.height + view.frame.origin.y
                )
            )
        )
        parent.backgroundColor = parentColor
        parent.addSubview(view)
        parent.bounds = view.frame
        return parent
    }
}
