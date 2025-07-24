//
//  UIViewController+AppScreen.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension HasAppScreen where Self: UIViewController {
    func setupScreenInfo() {
        if (title ?? "").isEmpty {
            title = screen.title
        }
        accessibilityLabel = screen.title
        view.accessibilityIdentifier = screen.accessibilityIdentifier
    }
}
