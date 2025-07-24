//
//  UIView+Accessibility.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension UIView {
    func findViews<T: UIView>(subclassOf: T.Type) -> [T] {
        recursiveSubviews().compactMap { $0 as? T }
    }

    private func recursiveSubviews() -> [UIView] {
        subviews + subviews.flatMap { $0.recursiveSubviews() }
    }
}
