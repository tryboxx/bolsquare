//
//  ContentCell.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

class ContentCell<Definition: ContentItemDefinition>: UITableViewCell, HasIdentifier {
    let container = UIView().withoutResizingMask()
    var containerInsets = ContentInsets.common {
        didSet {
            updateContainerInsets()
        }
    }

    private var leftEdgeConstraint: NSLayoutConstraint?
    private var rightEdgeConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(container)
        container.pinEdges([.top, .bottom], to: contentView)

        leftEdgeConstraint = container.leftAnchor
            .constraint(
                equalTo: contentView.leftAnchor,
                constant: containerInsets.insets.left
            )
            .activate()
        rightEdgeConstraint = container.rightAnchor
            .constraint(
                equalTo: contentView.rightAnchor,
                constant: -containerInsets.insets.right
            )
            .activate()
    }

    func configure(withDefinition definition: Definition) {
        if let insets = definition.customContentInsets {
            containerInsets = insets
        }
    }

    func resetContent() {
        container.removeAllSubviews()
    }

    private func updateContainerInsets() {
        leftEdgeConstraint?.constant = containerInsets.insets.left
        rightEdgeConstraint?.constant = -containerInsets.insets.right
    }

    class func estimateAvailableContentWidth(
        ifParentHas availableWidth: CGFloat,
        contentInsets: ContentInsets
    ) -> CGFloat {
        availableWidth - contentInsets.insets.left - contentInsets.insets.right
    }
}
