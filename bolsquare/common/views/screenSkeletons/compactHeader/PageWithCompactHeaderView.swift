//
//  PageWithCompactHeaderView.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

struct PageBackgroundConfiguration: Equatable {
    let headerHeight: CGFloat

    // if bigger than 0, then top cell shown above header view
    let topCellInset: CGFloat
}

class PageWithCompactHeaderView: UIView {
    var onOffsetChanged: ((CGFloat) -> Void)?

    var scrolledOffset: CGFloat {
        scrollView.contentOffset.y + scrollView.contentInset.top
    }

    let backgroundView = UIView().withoutResizingMask()
    let headerView: CompactHeaderView
    let scrollView = UIScrollView().withoutResizingMask()
    let contentView = UIView().withoutResizingMask()

    var headerHeight = CGFloat(0)

    var customHeaderTrackingView: UIView? {
        didSet {
            headerView.trackingView = customHeaderTrackingView
        }
    }

    let tapRecognizer = UITapGestureRecognizer()
    let viewStyle: AppStyle

    private var useCustomBackground: Bool {
        backgroundConfiguration != nil
    }

    private var customBackgroundHeight: CGFloat {
        backgroundConfiguration?.headerHeight ?? 0.0
    }

    private var customBackgroundTopInset: CGFloat {
        backgroundConfiguration?.topCellInset ?? 0.0
    }

    private var backgroundConfiguration: PageBackgroundConfiguration?
    private var backgroundTopConstraint: NSLayoutConstraint?
    private var backgroundHeightConstraint: NSLayoutConstraint?

    private var lastContentViewBounds = CGRect.zero

    init(
        withHeaderConfiguration configuration: HeaderConfiguration,
        backgroundConfiguration: PageBackgroundConfiguration? = nil,
        viewStyle: AppStyle? = nil
    ) {
        self.viewStyle = viewStyle ?? Styles.view
        self.backgroundConfiguration = backgroundConfiguration
        self.headerView = CompactHeaderView(withHeaderConfiguration: configuration).withoutResizingMask()

        super.init(frame: .zero)

        setupView()
        setupLayouts()
        setupStyles()

        if useCustomBackground {
            updateCustomBackgroundScrollInsets()
        }

        setUpTapGesture()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if headerHeight == 0 {
            updateHeaderHeight()
        }

        updateHeaderTrackingViewIfNeeded()
    }

    func updateHeaderHeight() {
        guard useCustomBackground == false else { return }

        headerHeight = headerView.estimatedHeight(forWidth: bounds.width)
        setTopInsetForScrolling(headerHeight + Layouts.contentInsets.top)
    }

    func setTopInsetForScrolling(_ inset: CGFloat) {
        scrollView.contentInset = UIEdgeInsets(top: inset, bottom: Layouts.contentInsets.bottom)
    }

    func scrollToTop(animated: Bool) {
        scrollView.setContentOffset(CGPoint(x: 0, y: -scrollView.adjustedContentInset.top), animated: animated)
    }

    func updateView(forScrolledOffset offset: CGFloat, animated: Bool) {
        if animated {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: UIView.AnimationOptions.beginFromCurrentState,
                animations: {
                    self.headerView.update(forScrolledOffset: offset, scrollContentView: self.contentView)
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                }
            )
        } else {
            headerView.update(forScrolledOffset: offset, scrollContentView: contentView)
        }
    }

    func setUpTapGesture() {
        tapRecognizer.addTarget(self, action: #selector(viewTapped))
        tapRecognizer.delegate = self
        contentView.addGestureRecognizer(tapRecognizer)
    }

    @objc func viewTapped() {
        contentView.dismissKeyboard()
    }

    func updateHeaderTrackingView() {
        guard customHeaderTrackingView == nil else { return }

        let trackingView = findHeaderTrackingView()
        headerView.trackingView = trackingView
    }
}

extension PageWithCompactHeaderView: UIGestureRecognizerDelegate {}

private extension PageWithCompactHeaderView {
    func updateHeaderTrackingViewIfNeeded() {
        if lastContentViewBounds != contentView.bounds {
            lastContentViewBounds = contentView.bounds
            updateHeaderTrackingView()
        }
    }

    func findHeaderTrackingView() -> UIView? {
        let labels = contentView.findViews(subclassOf: UILabel.self)
        if let topLabel = labels.findTopView(within: contentView) {
            return topLabel
        }

        return nil
    }
}

extension PageWithCompactHeaderView {
    func update(backgroundConfiguration: PageBackgroundConfiguration) {
        guard self.backgroundConfiguration != backgroundConfiguration else { return }
        self.backgroundConfiguration = backgroundConfiguration
        updateBackgroundHeightAndPosition()
        updateCustomBackgroundScrollInsets()
    }

    private func updateCustomBackgroundScrollInsets() {
        let safeAreaTop = DeviceUtils.safeTopArea
        scrollView.contentInset = UIEdgeInsets(top: customBackgroundHeight - safeAreaTop - customBackgroundTopInset)
    }

    private func updateBackgroundHeightAndPosition() {
        guard useCustomBackground else { return }

        let offset = scrolledOffset
        if offset > 0 {
            backgroundTopConstraint?.constant = -offset
            backgroundHeightConstraint?.constant = customBackgroundHeight
        } else {
            backgroundTopConstraint?.constant = 0
            var newHeight = customBackgroundHeight - offset / 2
            newHeight = min(newHeight, customBackgroundHeight * 1.2)
            backgroundHeightConstraint?.constant = newHeight
        }
    }
}

extension PageWithCompactHeaderView {
    private func setupView() {
        if useCustomBackground {
            addSubview(backgroundView)
        }

        addSubviews(scrollView, headerView)
        scrollView.addSubview(contentView)

        scrollView.delegate = self
    }

    private func setupLayouts() {
        if useCustomBackground {
            backgroundView.applyLayout(Layouts.background)
            backgroundTopConstraint = backgroundView.topAnchor.constraint(equalTo: topAnchor).activate()
            backgroundHeightConstraint = backgroundView.heightAnchor.constraint(equalToConstant: customBackgroundHeight).activate()
        }

        headerView.applyLayout(Layouts.header)

        scrollView.applyLayout(Layouts.scrollView)
        scrollView.contentInsetAdjustmentBehavior = .always

        contentView.applyLayout(Layouts.contentView)
        contentView.matchWidth(of: self)
    }

    private func setupStyles() {
        setup(appStyle: viewStyle)

        scrollView.showsVerticalScrollIndicator = false
    }
}

extension PageWithCompactHeaderView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentSize != .zero else { return }

        updateBackgroundHeightAndPosition()
        onOffsetChanged?(scrolledOffset)
        updateView(forScrolledOffset: scrolledOffset, animated: false)
    }

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {

        guard let trackingView = headerView.trackingView else { return }

        let trackingViewFrame = contentView.convert(trackingView.frame, from: trackingView.superview)
        var triggerYPoint = trackingViewFrame.minY
        // If trackingView is label, we want to find Y position of middle of first line in label
        if let trackingLabel = trackingView as? UILabel,
           let font = trackingLabel.font {
            triggerYPoint += font.lineHeight / 2.0
        } else { // otherwise trigger point is Y middle of trackingView
            triggerYPoint += trackingView.frame.midY
        }

        let relativeTarget = targetContentOffset.pointee.y + scrollView.adjustedContentInset.top
        let triggerRange: ClosedRange = trackingViewFrame.minY ... trackingViewFrame.maxY
        let hasTheSpace = scrollView.contentSize.height + scrollView.adjustedContentInset.top > scrollView.frame.height + triggerYPoint

        guard hasTheSpace, triggerRange.contains(relativeTarget) else { return }

        var targetY = targetContentOffset.pointee
        if relativeTarget > triggerYPoint {
            targetY.y = -scrollView.adjustedContentInset.top + trackingViewFrame.maxY
        } else {
            targetY.y = -scrollView.adjustedContentInset.top
        }

        targetContentOffset.pointee = targetY
    }
}

// MARK: - Constants
private extension PageWithCompactHeaderView {
    enum Styles {
        static let view = AppStyle.almostWhiteBackground
    }

    enum Layouts {
        static let background = layoutPinHorizontaly
        static let header = layoutPinAllExcludeBottom
        static let scrollView = layoutPinAllWithTopToSafeArea
        static let contentView = layoutPinAll
        static let contentInsets = UIEdgeInsets.zero
    }
}
