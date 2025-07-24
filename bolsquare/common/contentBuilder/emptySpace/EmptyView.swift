//
//  EmptyView.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

class EmptyView: UIView, AutoContentCell {

    private var desiredHeight = CGFloat(0) {
        didSet {
            if desiredHeight != oldValue {
                invalidateIntrinsicContentSize()
            }
        }
    }

    func configure(withDefinition definition: EmptyDefinition) {
        desiredHeight = definition.height
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: desiredHeight)
    }
}
