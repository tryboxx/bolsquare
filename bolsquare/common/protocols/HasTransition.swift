//
//  HasTransition.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

protocol HasTransition: UIViewController {
    func transitionTo(wasShownVC: UIViewController?) -> CATransitionType?
    func transitionFrom(willShowVC: UIViewController) -> CATransitionType?
    func transitionBackFrom(willShowVC: UIViewController?) -> CATransitionType?
    func transitionBackTo(wasShownVC: UIViewController) -> CATransitionType?
    func transitionTime() -> TimeInterval?
}

extension HasTransition {
    func transitionTo(wasShownVC: UIViewController?) -> CATransitionType? {
        nil
    }

    func transitionFrom(willShowVC: UIViewController) -> CATransitionType? {
        nil
    }

    func transitionBackFrom(willShowVC: UIViewController?) -> CATransitionType? {
        nil
    }

    func transitionBackTo(wasShownVC: UIViewController) -> CATransitionType? {
        nil
    }

    func transitionTime() -> TimeInterval? {
        nil
    }
}
