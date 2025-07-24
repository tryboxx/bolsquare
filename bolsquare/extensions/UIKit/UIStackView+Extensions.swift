//
//  UIStackView+Extensions.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension UIStackView {

    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach(addArrangedSubview(_:))
    }

    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach(addArrangedSubview(_:))
    }

    func removeAllArrangedSubviews() {
        for view in arrangedSubviews {
            view.removeFromSuperview()
        }
    }

    func addSpace(_ space: CGFloat) {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: space).prioritize(.defaultHigh).activate()
        view.heightAnchor.constraint(equalToConstant: space).prioritize(.defaultHigh).activate()
        addArrangedSubview(view)
    }
}

extension UIStackView {

    convenience init(
        _ arrangedSubviews: [UIView] = [],
        axis: NSLayoutConstraint.Axis = .vertical,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 8
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}
