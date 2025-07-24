//
//  UIButton+Accessibility.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension UIButton {

    func findAccessibilityLabel() -> String? {
        if let label = findLabel(),
           let text = label.text {
            return text
        }

        return nil
    }

    func findAccessibilityIdentifier() -> String {
        if let label = findLabel(),
           let text = label.text {
            return text
        }

        return String(describing: Self.self)
    }

    private func findLabel() -> UILabel? {
        findViews(subclassOf: UILabel.self)
            .first(where: {
                !$0.isHidden &&
                !($0.superview?.isHidden ?? false) &&
                !($0.text?.isEmpty ?? true)
            })
    }
}
