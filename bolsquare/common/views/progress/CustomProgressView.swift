//
//  CustomProgressView.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

private enum Styles {
    static let title = AppStyle.body1
    static let titleText = title.textStyle?.centered()
    static let progress = AppStyle.subtitle2
    static let progressText = progress.textStyle?.centered()
    static let spinnerColor = Colors.green600.color
    static let progressColor = Colors.green600.color
}

private enum Layouts {
    static let defaultWidth = CGFloat(120)
    static let progressLabelBottomDistance = CGFloat(8)
    static let progressViewBottomDistance = CGFloat(8)
    static let spinnerTopDistance = CGFloat(8)
    static let spinnerBottomDistance = CGFloat(8)
}

enum CustomProgressViewMode {
    case indeterminate
    case horizontalProgress
    case horizontalPlain
}

class CustomProgressView: UIView {
    private let mode: CustomProgressViewMode
    var progress: Float = 0.0 {
        didSet {
            showProgress(progress)
        }
    }

    var title: String = L10n.Common.loading {
        didSet {
            showTitle(title)
        }
    }

    private let container = UIView().withoutResizingMask()
    private let titleLabel = UILabel(appStyle: Styles.title, customTextStyle: Styles.titleText).withoutResizingMask()
    private let progressLabel = UILabel(appStyle: Styles.progress, customTextStyle: Styles.progressText).withoutResizingMask()
    private let progressView: UIProgressView = {
        let view = UIProgressView().withoutResizingMask()
        view.progressTintColor = Styles.progressColor
        return view
    }()

    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium).withoutResizingMask()
        view.hidesWhenStopped = true
        view.color = Styles.spinnerColor
        return view
    }()

    init(forMode mode: CustomProgressViewMode) {
        self.mode = mode
        super.init(frame: CGRect.zero)
        setupView()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func showTitle(_ title: String) {
        titleLabel.styledText = title
    }

    private func showProgress(_ progress: Float) {
        let percentage = progress * 100.0
        let text = String(format: "%.0f%%", percentage)
        progressLabel.styledText = text
        progressView.setProgress(progress, animated: AppUI.animationsEnabled)
    }
}

extension CustomProgressView {
    private func setupView() {
        addSubview(container)
        switch mode {
        case .indeterminate:
            container.addSubviews(titleLabel, spinner)
            spinner.startAnimating()
        case .horizontalProgress:
            container.addSubviews(progressLabel, progressView, titleLabel)
            showProgress(progress)
        case .horizontalPlain:
            container.addSubviews(progressView)
            showProgress(progress)
        }

        showTitle(title)
    }

    private func setupLayout() {
        container.pinEdges(to: self)
        container.widthAnchor.constraint(equalToConstant: Layouts.defaultWidth).activate()
        switch mode {
        case .indeterminate: setupIndeterminateLoadingLayout()
        case .horizontalProgress: setupProgressLayout()
        case .horizontalPlain: setupProgressPlainLayout()
        }
    }

    private func setupIndeterminateLoadingLayout() {
        spinner.pinEdge(.top, to: container, offset: Layouts.spinnerTopDistance)
        spinner.pinEdge(.bottom, toOpposite: titleLabel, offset: Layouts.spinnerBottomDistance)
        spinner.centerX(in: container)
        titleLabel.pinEdges([.left, .bottom, .right], to: container)
    }

    private func setupProgressLayout() {
        progressLabel.pinEdge(.bottom, toOpposite: progressView, offset: Layouts.progressLabelBottomDistance)
        progressLabel.pinEdge(.top, to: container)
        progressLabel.centerX(in: container)

        progressView.pinEdges([.left, .right], to: container)
        progressView.pinEdge(.bottom, toOpposite: titleLabel, offset: Layouts.progressViewBottomDistance)

        titleLabel.pinEdges([.left, .bottom, .right], to: container)
    }

    private func setupProgressPlainLayout() {
        progressView.pinEdges(.all, to: container)
    }
}
