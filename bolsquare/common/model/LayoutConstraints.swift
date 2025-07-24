//
//  LayoutConstraints.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

final class LayoutConstraints {
    var left: NSLayoutConstraint?
    var right: NSLayoutConstraint?
    var top: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    var centerX: NSLayoutConstraint?
    var centerY: NSLayoutConstraint?

    init(
        left: NSLayoutConstraint? = nil,
        right: NSLayoutConstraint? = nil,
        top: NSLayoutConstraint? = nil,
        bottom: NSLayoutConstraint? = nil,
        centerX: NSLayoutConstraint? = nil,
        centerY: NSLayoutConstraint? = nil
    ) {
        self.left = left
        self.right = right
        self.top = top
        self.bottom = bottom
        self.centerX = centerX
        self.centerY = centerY
    }

    func update(withContentInsets contentInsets: ContentInsets) {
        left?.constant = contentInsets.leftInset
        right?.constant = -contentInsets.rightInset
        top?.constant = contentInsets.topInset
        bottom?.constant = -contentInsets.bottomInset
    }
}
