//
//  UIEdgeInsets+Extensions.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension UIEdgeInsets {

    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    init(top: CGFloat = 0, bottom: CGFloat = 0, horizontal: CGFloat = 0) {
        self.init(top: top, left: horizontal, bottom: bottom, right: horizontal)
    }

    init(all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }

    init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
        self.init(top: top ?? 0, left: left ?? 0, bottom: bottom ?? 0, right: right ?? 0)
    }

    func with(verticalInset: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: verticalInset, left: left, bottom: verticalInset, right: right)
    }
}

extension NSDirectionalEdgeInsets {

    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    init(top: CGFloat = 0, bottom: CGFloat = 0, horizontal: CGFloat = 0) {
        self.init(top: top, leading: horizontal, bottom: bottom, trailing: horizontal)
    }

    init(all: CGFloat) {
        self.init(top: all, leading: all, bottom: all, trailing: all)
    }
}
