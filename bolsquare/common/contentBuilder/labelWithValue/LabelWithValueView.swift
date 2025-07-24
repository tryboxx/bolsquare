//
//  LabelWithValueView.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

class LabelWithValueView: CommonButton, AutoContentCell {
    private let mainPart = UIView().withoutResizingMask()
    private let nameLabel: UILabel = {
        let view = UILabel().withoutResizingMask()
        view.setup(appStyle: Styles.nameStyle, customTextStyle: Styles.nameTextStyle)
        return view
    }()

    private let valueLabel: UILabel = {
        let view = UILabel().withoutResizingMask()
        view.setup(appStyle: Styles.valueStyle, customTextStyle: Styles.valueTextStyle)
        return view
    }()

    private let separator: UIView = {
        let view = UIView().withoutResizingMask()
        view.setup(appStyle: Styles.separator)
        return view
    }()

    private var definition: LabelWithValueDefinition?

    init() {
        super.init(frame: CGRect.zero)
        setupView()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withDefinition definition: LabelWithValueDefinition) {
        self.definition = definition
        accessibilityValue = definition.value

        if let nameStyle = definition.customNameStyle {
            nameLabel.style(CompoundStyle(textStyle: nameStyle.textStyle?.oneLineOnly(), colorStyle: nameStyle.colorStyle))
        }

        if let valueStyle = definition.customValueStyle {
            valueLabel.style(CompoundStyle(textStyle: valueStyle.textStyle?.oneLineOnly(), colorStyle: valueStyle.colorStyle))
        }

        nameLabel.styledText = definition.name
        valueLabel.styledText = definition.value

        isEnabled = false

        if definition.hideSeparator {
            separator.isHidden = true
        }
    }

    func reset() {
        definition = nil
        nameLabel.styledText = nil
        valueLabel.styledText = nil
    }
}

extension LabelWithValueView {
    private func setupView() {
        addSubviews(mainPart, separator)
        [mainPart, separator].forEach { $0.isUserInteractionEnabled = false }
        mainPart.addSubviews(nameLabel, valueLabel)

        onAction = { [weak self] in }
    }

    private func setupLayout() {
        mainPart.applyLayout(layoutPinAll)

        nameLabel.applyLayout(layoutPinHorizontaly)
        nameLabel.topAnchor
            .constraint(
                equalTo: mainPart.topAnchor,
                constant: Layouts.mainPartTopMargin
            )
            .activate()

        valueLabel.applyLayout(layoutPinHorizontaly)
        valueLabel.numberOfLines = .zero

        valueLabel.topAnchor
            .constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: Layouts.valueDistance
            )
            .activate()

        separator.applyLayout(layoutPinAllExcludeTop)
        separator.setHeight(height: Layouts.separatorHeight)

        separator.topAnchor
            .constraint(
                equalTo: valueLabel.bottomAnchor,
                constant: Layouts.valueDistance
            )
            .activate()
    }
}

// MARK: - estimating height
extension LabelWithValueView {
    class func estimateHeight(
        forAvailableWidth availableWidth: CGFloat,
        definition: LabelWithValueDefinition
    ) -> CGFloat {
        Layouts.defaultHight
    }
}

private enum Styles {
    static let nameStyle = AppStyle.label
    static let nameTextStyle = nameStyle.textStyle?.oneLineOnly()
    static let valueStyle = AppStyle.body3
    static let valueTextStyle = valueStyle.textStyle?.oneLineOnly()
    static let separator = AppStyle.separator
}

private enum Layouts {
    static let defaultHight = CGFloat(64)
    static let mainPartTopMargin = CGFloat(12)

    static let valueDistance = CGFloat(8)
    static let separatorHeight = CGFloat(1)
}
