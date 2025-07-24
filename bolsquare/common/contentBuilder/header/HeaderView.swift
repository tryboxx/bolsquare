//
//  HeaderView.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

private enum Layouts {
    static let informationButtonDistance = CGFloat(-4) // informationButton already has inset inside
    static let titleRightMarginWhenHintIsVisible = CGFloat(32)
    static let hintTopDistance = CGFloat(16)
    static let hintBottomMargin = CGFloat(8)
}

class HeaderView: CommonButton, AutoContentCell {

    private let headerLabel = UILabel().withoutResizingMask()
    private var titleRightConstraint: NSLayoutConstraint?
    private var titleBottomConstraint: NSLayoutConstraint?
    private var definition: HeaderDefinition?

    init() {
        super.init(frame: CGRect.zero)
        addSubviews(headerLabel)
        headerLabel.isUserInteractionEnabled = false
        headerLabel.pinEdges([.left, .top], to: self)
        headerLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        headerLabel.setContentHuggingPriority(.required, for: .vertical)

        self.titleBottomConstraint = headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).activate()
        self.titleRightConstraint = headerLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).activate()

        self.onAction = { [weak self] in }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withDefinition definition: HeaderDefinition) {
        self.definition = definition
        headerLabel.setup(appStyle: definition.style.appStyle)
        headerLabel.styledText = definition.title
    }

    func reset() {
        definition = nil
        headerLabel.styledText = nil
        titleRightConstraint?.constant = 0
    }
}

// MARK: - estimating height
extension HeaderView {
    class func estimateHeight(
        forAvailableWidth availableWidth: CGFloat,
        definition: HeaderDefinition
    ) -> CGFloat {
        let attributedTitle = definition.title.attributedWith(viewStyle: definition.style.appStyle.viewStyle)
        var titleAvailableWidth = availableWidth
        let titleHeight = attributedTitle.heightWithConstrainedWidth(width: titleAvailableWidth)

        return titleHeight
    }
}
