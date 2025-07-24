//
//  UIView+Keyboard.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension UIView {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func findFirstResponderAmongDescendants() -> UIView? {
        for subview in subviews {
            if subview.isFirstResponder {
                return subview
            }

            if let result = subview.findFirstResponderAmongDescendants() {
                return result
            }
        }

        return nil
    }

    func isAnyOfDescendantsFirstResponder() -> Bool {
        findFirstResponderAmongDescendants() != nil
    }
}
