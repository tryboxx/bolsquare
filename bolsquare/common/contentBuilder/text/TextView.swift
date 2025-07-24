//
//  TextView.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

private enum Styles {
    static let text = AppStyle.body3
}

class TextView: UIView, AutoContentCell {

    var text: String? {
        textLabel.text
    }

    private let textLabel = UILabel().withoutResizingMask()

    init() {
        super.init(frame: CGRect.zero)
        addSubview(textLabel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withDefinition definition: TextDefinition) {
        switch definition.content {
        case .attributed(let attributedDefinition):
            textLabel.attributedText = attributedDefinition.attributedText
            if let numberOfLines = attributedDefinition.numberOfLines {
                textLabel.numberOfLines = numberOfLines
            }
            if let lineBreakMode = attributedDefinition.lineBreakMode {
                textLabel.lineBreakMode = lineBreakMode
            }
        case .styled(let styledDefinition):
            textLabel.setup(
                appStyle: Styles.text,
                customColorStyle: styledDefinition.colorStyle,
                customTextStyle: styledDefinition.textStyle
            )
            textLabel.styledText = styledDefinition.text
            if let alignment = styledDefinition.textAlignment {
                textLabel.textAlignment = alignment
            }
        }

        textLabel.pinEdges([.left, .top], to: self, insets: definition.insets ?? .zero)
        textLabel.pinEdges([.bottom, .right], to: self, insets: definition.insets ?? .zero, priority: UILayoutPriority(rawValue: 999))
    }

    func reset() {
        textLabel.attributedText = nil
    }
}
