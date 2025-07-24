//
//  IndicatorView.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

final class IndicatorView: UIView, AutoContentCell {

    private var definition: IndicatorDefinition?

    private let containerView = UIView()
    private let indicator = UIActivityIndicatorView(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(containerView)
        containerView.addSubview(indicator)

        setupLayouts()
        setupStyles()

        restartIndicator()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(withDefinition definition: IndicatorDefinition) {
        self.definition = definition
    }

    func restartIndicator() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
}

// MARK: - Private interface
private extension IndicatorView {

    func setupLayouts() {
        containerView.applyLayout(Layouts.containerView)
        indicator.applyLayout(Layouts.indicator)
    }

    func setupStyles() {
        containerView.style(Styles.containerView)
        indicator.color = Styles.indicatorColor
    }
}

// MARK: - Constants
private extension IndicatorView {

    enum Layouts {
        static let containerView = layoutPinAll
        static let indicator = Layout(left: .alignToCenter, parent: layoutPinVertically)
    }

    enum Styles {
        static let containerView = CompoundStyle(colorStyle: ColorStyle(backgroundColor: UIColor.clear))
        static let indicatorColor = Colors.green1000.color
    }
}
