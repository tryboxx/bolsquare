//
//  CompactHeaderView.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

class CompactHeaderView: UIView {

    private let backgroundContainer = UIView().withStyle(Styles.view.viewStyle).withoutResizingMask()
    private let topContainer = UIView().withoutResizingMask()
    private let topStack = UIStackView(
        [],
        axis: .horizontal,
        alignment: .fill,
        distribution: .fill,
        spacing: Layouts.topStackSpacing
    )

    let backButton: CommonButton = {
        let button = CommonButton(image: Images.compactHeaderBackButton.image).withoutResizingMask()
        return button
    }()

    let closeButton: CommonButton = {
        let button = CommonButton(image: Images.compactHeaderCloseButton.image).withoutResizingMask()
        return button
    }()

    let titleLabel = UILabel().withStyle(Styles.title).withoutResizingMask()

    var trackingView: UIView? {
        didSet {
            guard configuration.title == nil else { return }
            if let trackingLabel = trackingView as? UILabel {
                let title = trackingLabel.text ?? trackingLabel.attributedText?.string
                titleLabel.styledText = title
            }
        }
    }

    private let leftButtonPlaceholder = UIView().withoutResizingMask()
    private let rightButtonPlaceholder = UIView().withoutResizingMask()

    private let separator = UIView().withStyle(Styles.separator.viewStyle).withoutResizingMask()

    private let configuration: HeaderConfiguration

    init(withHeaderConfiguration configuration: HeaderConfiguration) {
        self.configuration = configuration

        super.init(frame: .zero)

        titleLabel.styledText = configuration.title

        var hasAnyLeftButton = false
        if configuration.backAction != nil {
            backButton.onAction = { [weak configuration] in
                configuration?.backAction?()
            }
            backButton.isHidden = false
            hasAnyLeftButton = true
        } else {
            backButton.isHidden = true
        }

        var hasAnyRightButton = false
        if configuration.closeAction != nil {
            closeButton.onAction = { [weak configuration] in
                configuration?.closeAction?()
            }
            closeButton.isHidden = false
            hasAnyRightButton = true
        } else {
            closeButton.isHidden = true
        }

        let hasAnyButton = hasAnyLeftButton || hasAnyRightButton
        if hasAnyButton {
            leftButtonPlaceholder.isHidden = hasAnyLeftButton
            rightButtonPlaceholder.isHidden = hasAnyRightButton
        } else {
            leftButtonPlaceholder.isHidden = true
            rightButtonPlaceholder.isHidden = true
        }

        setupView()
        setupLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func update(forScrolledOffset offset: CGFloat, scrollContentView: UIView) {
        var targetOffset = Layouts.defaultTrackingOffset

        if let trackingView {
            let frameWithinSuperview = trackingView.convert(trackingView.frame, to: scrollContentView)
            targetOffset = frameWithinSuperview.minY

            if let scrollView = scrollContentView.superview as? UIScrollView {
                let distanceBetweenHeaderAndContentView = scrollView.frame.minY + scrollView.adjustedContentInset.top - frame.maxY
                targetOffset += distanceBetweenHeaderAndContentView
            }
        }

        updateTitle(visible: offset > targetOffset)
    }

    private func updateTitle(visible: Bool) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .beginFromCurrentState,
            animations: { [weak self] in
                self?.backgroundContainer.alpha = visible ? 1.0 : 0.0
                self?.titleLabel.alpha = visible ? 1.0 : 0.0
            }
        )
    }

    private func setupView() {

        addSubviews(backgroundContainer, topContainer)
        backgroundContainer.addSubview(separator)
        topContainer.addSubview(topStack)

        topStack.addArrangedSubviews(leftButtonPlaceholder, backButton, titleLabel, closeButton, rightButtonPlaceholder)

        backgroundContainer.alpha = 0.0

        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.alpha = 0.0

        backButton.setContentHuggingPriority(.required, for: .horizontal)
        closeButton.setContentHuggingPriority(.required, for: .horizontal)

        backButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        closeButton.setContentCompressionResistancePriority(.required, for: .horizontal)

        leftButtonPlaceholder.setSize(Layouts.buttonSize)
        rightButtonPlaceholder.setSize(Layouts.buttonSize)
    }

    private func setupLayouts() {
        backgroundContainer.applyLayout(Layouts.backgroundContainer)
        separator.applyLayout(Layouts.separator)
        topContainer.applyLayout(Layouts.topContainer)
        topStack.applyLayout(Layouts.topStack)
    }
}

extension CompactHeaderView {
    func estimatedHeight(forWidth width: CGFloat) -> CGFloat {
        guard width > 0 else { return 0 }

        var height = Layouts.topStack.margins?.top ?? 0
        height += Layouts.buttonSize.height
        height += Layouts.topStack.margins?.bottom ?? 0

        return height
    }
}

private extension CompactHeaderView {
    enum Styles {
        static let view = AppStyle.almostWhiteBackground
        static let title = CompoundStyle(
            textStyle: AppStyle.subtitle2.textStyle?.oneLineOnlyPreservingLineHeight().centered(),
            colorStyle: AppStyle.subtitle2.colorStyle
        )
        static let separator = AppStyle.separator
    }

    enum Layouts {
        static let margins = UIEdgeInsets(horizontal: 16, vertical: 0)
        static let backgroundContainer = layoutPinAll
        static let topContainer = layoutPinAllToSafeArea
        static let topStack = Layout(margins: UIEdgeInsets(top: 16, bottom: 16, horizontal: margins.left), parent: layoutPinAll)
        static let topStackSpacing = CGFloat(16)
        static let buttonSize = CGSize(width: 40, height: 40)
        static let separator = Layout(height: 1, parent: layoutPinAllExcludeTop)
        static let defaultTrackingOffset = CGFloat(24)
    }
}
