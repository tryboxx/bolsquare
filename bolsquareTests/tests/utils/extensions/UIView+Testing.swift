//
//  UIView+Testing.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation
import UIKit

extension UIView {
    func embedWithMargin(_ margin: CGFloat, background: UIColor? = nil) -> UIView {
        frame = CGRect(origin: .zero, size: systemLayoutSizeFitting(CGSize(width: CGFloat.infinity, height: CGFloat.infinity)))
        let parent = UIView(frame: frame.inset(by: UIEdgeInsets(top: -margin, left: -margin, bottom: -margin, right: -margin)))
        parent.backgroundColor = background
        parent.addSubview(self)
        frame = bounds.offsetBy(dx: margin, dy: margin)
        return parent
    }

    func embed(
        inTestSize size: CGSize = CGSize(width: 375, height: 200),
        fillWidth: Bool = true,
        fillAllSize: Bool = false,
        margin: CGFloat = CGFloat(0),
        background: UIColor? = nil
    ) -> UIView {
        let viewFrame = CGRect(origin: CGPoint.zero, size: size)
        let parent = UIView(frame: viewFrame)
        parent.backgroundColor = background
        parent.addSubview(self)

        leftAnchor.constraint(equalTo: parent.leftAnchor, constant: margin).isActive = true
        if fillWidth {
            rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -margin).isActive = true
        } else {
            rightAnchor.constraint(lessThanOrEqualTo: parent.rightAnchor, constant: -margin).isActive = true
        }
        topAnchor.constraint(equalTo: parent.topAnchor, constant: margin).isActive = true
        if fillAllSize {
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -margin).isActive = true
        }
        return parent
    }

    func findSubviews<T: UIView>() -> [T] {
        var result = [T]()
        if let view = self as? T {
            result.append(view)
        }
        for subview in subviews {
            result += subview.findSubviews()
        }
        return result
    }

    /// Uses `systemLayoutSizeFitting` to set the size of the view to the minimum that its constraints will allow. Useful for views who grow
    /// with their contents vertically.
    func sizeToFit(width: CGFloat) {
        let size = systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        frame.size = CGSize(width: width, height: size.height)
    }

    /// Uses `systemLayoutSizeFitting` to set the size of the view to the minimum that its constraints will allow. Useful for views who grow
    /// with their contents horizontally.
    func sizeToFit(height: CGFloat) {
        let size = systemLayoutSizeFitting(
            CGSize(width: UIView.layoutFittingCompressedSize.width, height: height),
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )
        frame.size = CGSize(width: size.width, height: height)
    }
}
