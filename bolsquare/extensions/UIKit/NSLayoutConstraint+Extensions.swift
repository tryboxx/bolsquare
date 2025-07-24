//
//  NSLayoutConstraint+Extensions.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension NSLayoutConstraint {

    @discardableResult
    func prioritize(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    @discardableResult
    func activate() -> NSLayoutConstraint {
        isActive = true
        return self
    }

    @discardableResult
    func deactivate() -> NSLayoutConstraint {
        isActive = false
        return self
    }
}
