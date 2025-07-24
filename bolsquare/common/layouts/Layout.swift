//
//  Layout.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

enum EdgeType {
    case alignToCenter
    case pin
    case pinSafe
    case pinLess
}

enum Hugging {
    case expand
    case hug
    case custom(Float)
}

enum Resistance {
    case allow
    case block
    case custom(Float)
}

// swiftlint:disable file_length
struct Layout {
    let margins: UIEdgeInsets?
    let paddings: UIEdgeInsets?
    let width: CGFloat?
    let height: CGFloat?
    let heightPriority: UILayoutPriority?
    let widthScale: CGFloat?
    let heightScale: CGFloat?
    let left: EdgeType?
    let right: EdgeType?
    let top: EdgeType?
    let bottom: EdgeType?
    let hOffset: CGFloat?
    let vOffset: CGFloat?
    let hHugging: Hugging?
    let vHugging: Hugging?
    let hResistance: Resistance?
    let vResistance: Resistance?

    init(
        margins: UIEdgeInsets? = nil,
        paddings: UIEdgeInsets? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        heightPriority: UILayoutPriority? = nil,
        widthScale: CGFloat? = nil,
        heightScale: CGFloat? = nil,
        left: EdgeType? = nil,
        right: EdgeType? = nil,
        top: EdgeType? = nil,
        bottom: EdgeType? = nil,
        hOffset: CGFloat? = nil,
        vOffset: CGFloat? = nil,
        hHugging: Hugging? = nil,
        vHugging: Hugging? = nil,
        hResistance: Resistance? = nil,
        vResistance: Resistance? = nil,
        parent: Layout? = nil
    ) {

        self.margins = margins ?? parent?.margins
        self.paddings = paddings ?? parent?.paddings
        self.width = width ?? parent?.width
        self.height = height ?? parent?.height
        self.heightPriority = heightPriority ?? parent?.heightPriority
        self.widthScale = widthScale ?? parent?.widthScale
        self.heightScale = heightScale ?? parent?.heightScale
        self.left = left ?? parent?.left
        self.right = right ?? parent?.right
        self.top = top ?? parent?.top
        self.bottom = bottom ?? parent?.bottom
        self.hOffset = hOffset ?? parent?.hOffset
        self.vOffset = vOffset ?? parent?.vOffset
        self.hHugging = hHugging ?? parent?.hHugging
        self.vHugging = vHugging ?? parent?.vHugging
        self.hResistance = hResistance ?? parent?.hResistance
        self.vResistance = vResistance ?? parent?.vResistance
    }

    var horizontalMargins: CGFloat { (margins?.left ?? 0) + (margins?.right ?? 0) }
    var verticalMargins: CGFloat { (margins?.top ?? 0) + (margins?.bottom ?? 0) }
    var midX: CGFloat { (margins?.left ?? 0) + (width ?? 0) / 2 }
    var midY: CGFloat { (margins?.top ?? 0) + (height ?? 0) / 2 }
}

struct ViewAndLayout<ViewType: UIView> {
    let view: ViewType
    let style: Layout

    @discardableResult func autoPinEdge(
        _ edge: UIRectEdge,
        toOpositeEdgeInView opositeView: UIView,
        style: Layout
    ) -> ViewAndLayout {
        let opositeEdge = opposite(edge: edge)
        let distance = self.style.margin(forEdge: edge) + style.margin(forEdge: opositeEdge)
        view.pinEdge(edge, toOpposite: opositeView, offset: distance)
        return self
    }

    @discardableResult func autoPinEdge(
        _ edge: UIRectEdge,
        toOpositeEdgeInView opositeView: ViewAndLayout
    ) -> ViewAndLayout {
        let opositeEdge = opposite(edge: edge)
        let distance = style.margin(forEdge: edge) + opositeView.style.margin(forEdge: opositeEdge)
        view.pinEdge(edge, toOpposite: opositeView.view, offset: distance)
        return self
    }

    @discardableResult func autoPinEdge(
        _ edge: UIRectEdge,
        toEdge secondViewEdge: UIRectEdge,
        inView secondView: UIView,
        style: Layout
    ) -> ViewAndLayout {
        let distance = self.style.margin(forEdge: edge) + style.margin(forEdge: secondViewEdge)
        view.pinEdge(edge, to: secondViewEdge, of: secondView, offset: distance)
        return self
    }

    @discardableResult func autoPinEdges(toSameEdgesInView view: UIView) -> ViewAndLayout {
        autoPinEdges(toSameEdgesInView: view, excludingEdges: [])
    }

    @discardableResult func autoPinEdges(toSameEdgesInView secondView: UIView, excludingEdge: UIRectEdge) -> ViewAndLayout {
        autoPinEdges(toSameEdgesInView: secondView, excludingEdges: [excludingEdge])
    }

    @discardableResult func autoPinEdge(edge: UIRectEdge, toSameEdgeInView secondView: UIView) -> ViewAndLayout {
        view.pinEdge(edge, to: edge, of: secondView, offset: 0)
        return self
    }

    @discardableResult func autoPinEdges(toSameEdgesInView secondView: UIView, excludingEdges: [UIRectEdge]) -> ViewAndLayout {

        [UIRectEdge.top, UIRectEdge.bottom, UIRectEdge.left, UIRectEdge.right].forEach { edge in
            guard !excludingEdges.contains(edge) else { return }
            view.pinEdge(edge, to: edge, of: secondView, offset: style.margin(forEdge: edge))
        }
        return self
    }

    @discardableResult func sameWidth(as secondView: UIView, inset: CGFloat = 0) -> ViewAndLayout {
        view.matchWidth(of: secondView, inset: inset)
        return self
    }

    @discardableResult func sameHeight(as secondView: UIView) -> ViewAndLayout {
        view.matchHeight(of: secondView)
        return self
    }

    private func opposite(edge: UIRectEdge) -> UIRectEdge {
        switch edge {
        case .top: return .bottom
        case .bottom: return .top
        case .left: return .right
        case .right: return .left
        default: fatalError("Unsupported layout edge")
        }
    }
}

extension Layout {
    func margin(forEdge edge: UIRectEdge) -> CGFloat {
        switch edge {
        case .top: return margins?.top ?? 0
        case .bottom: return margins?.bottom ?? 0
        case .left: return margins?.left ?? 0
        case .right: return margins?.right ?? 0
        default: fatalError("Unsupported layout edge")
        }
    }

    static func heightConstraint(in view: UIView) -> NSLayoutConstraint? {
        view.constraints.first(where: { constraint -> Bool in
            constraint.firstAttribute == NSLayoutConstraint.Attribute.height
        })
    }

    static func bottomConstraint(of view: UIView) -> NSLayoutConstraint? {
        view.superview?.constraints.first(where: { constraint -> Bool in
            (constraint.firstAttribute == NSLayoutConstraint.Attribute.bottom &&
                        (constraint.firstItem as? UIView) == view)
                || (constraint.secondAttribute == NSLayoutConstraint.Attribute.bottom &&
                        (constraint.secondItem as? UIView) == view)
        })
    }

    static func topConstraint(of view: UIView) -> NSLayoutConstraint? {
        view.superview?.constraints.first(where: { constraint -> Bool in
            (constraint.firstAttribute == NSLayoutConstraint.Attribute.top &&
                        (constraint.firstItem as? UIView) == view)
                || (constraint.secondAttribute == NSLayoutConstraint.Attribute.top &&
                        (constraint.secondItem as? UIView) == view)
        })
    }

    static func centerXConstraint(of view: UIView) -> NSLayoutConstraint? {
        view.superview?.constraints.first(where: { constraint -> Bool in
            (constraint.firstAttribute == NSLayoutConstraint.Attribute.centerX &&
                        (constraint.firstItem as? UIView) == view)
                || (constraint.secondAttribute == NSLayoutConstraint.Attribute.centerX &&
                        (constraint.secondItem as? UIView) == view)
        })
    }

    static func stackVertically(_ views: ViewAndLayout<UIView>...) {
        stackVertically(views)
    }

    static func stackVertically(_ views: [ViewAndLayout<UIView>]) {
        for (firstView, secondView) in zip(views, views.dropFirst()) {
            secondView.autoPinEdge(UIRectEdge.top, toOpositeEdgeInView: firstView.view, style: firstView.style)
        }
    }

    static func stackHorizontally(_ views: [ViewAndLayout<UIView>]) {
        for (firstView, secondView) in zip(views, views.dropFirst()) {
            secondView.autoPinEdge(UIRectEdge.left, toOpositeEdgeInView: firstView.view, style: firstView.style)
        }
    }

    static func stackHorizontally(_ views: ViewAndLayout<UIView>...) {
        stackHorizontally(views)
    }
}

extension UIView {
    // swiftlint:disable:next function_body_length cyclomatic_complexity
    @discardableResult func applyLayout(_ style: Layout) -> ViewAndLayout<UIView> {

        translatesAutoresizingMaskIntoConstraints = false

        // Size
        if let width = style.width {
            setWidth(width: width)
        }

        if let height = style.height {
            setHeight(height: height).prioritize(style.heightPriority ?? UILayoutPriority.required)
        }

        // Horizontal align
        if style.left == EdgeType.alignToCenter || style.right == EdgeType.alignToCenter {

            if let parentView = superview {
                centerX(in: parentView, offset: style.hOffset ?? 0)
            } else {
                fatalError("Tried to align view in without superview")
            }
        }

        // Vertical align
        if style.top == EdgeType.alignToCenter || style.bottom == EdgeType.alignToCenter {
            if let parentView = superview {
                centerY(in: parentView, offset: style.vOffset ?? 0)
            } else {
                fatalError("Tried to align view without superview")
            }
        }

        // Pin PinSafe PinLess
        if let parentView = superview {
            if style.left == EdgeType.pin {
                pinEdge(UIRectEdge.left, to: parentView, offset: style.margin(forEdge: .left))
            } else if style.left == EdgeType.pinSafe {
                pinEdge(UIRectEdge.left, to: parentView.safeAreaLayoutGuide, offset: style.margin(forEdge: .left))
            } else if style.left == EdgeType.pinLess {
                pinEdgeToBeLessThanOrEqualTo(UIRectEdge.left, to: parentView, offset: style.margin(forEdge: .left))
            }

            if style.right == EdgeType.pin {
                pinEdge(UIRectEdge.right, to: parentView, offset: style.margin(forEdge: .right))
            } else if style.right == EdgeType.pinSafe {
                pinEdge(UIRectEdge.right, to: parentView.safeAreaLayoutGuide, offset: style.margin(forEdge: .right))
            } else if style.right == EdgeType.pinLess {
                pinEdgeToBeLessThanOrEqualTo(UIRectEdge.right, to: parentView, offset: style.margin(forEdge: .right))
            }

            if style.top == EdgeType.pin {
                pinEdge(UIRectEdge.top, to: parentView, offset: style.margin(forEdge: .top))
            } else if style.top == EdgeType.pinSafe {
                pinEdge(UIRectEdge.top, to: parentView.safeAreaLayoutGuide, offset: style.margin(forEdge: .top))
            } else if style.top == EdgeType.pinLess {
                pinEdgeToBeLessThanOrEqualTo(UIRectEdge.top, to: parentView, offset: style.margin(forEdge: .top))
            }

            if style.bottom == EdgeType.pin {
                pinEdge(UIRectEdge.bottom, to: parentView, offset: style.margin(forEdge: .bottom))
            } else if style.bottom == EdgeType.pinSafe {
                pinEdge(UIRectEdge.bottom, to: parentView.safeAreaLayoutGuide, offset: style.margin(forEdge: .bottom))
            } else if style.bottom == EdgeType.pinLess {
                pinEdgeToBeLessThanOrEqualTo(UIRectEdge.bottom, to: parentView, offset: style.margin(forEdge: .bottom))
            }
        }

        // Hugging priority
        if let hHugging = style.hHugging {
            setContentHuggingPriority(priority(forHuggin: hHugging), for: NSLayoutConstraint.Axis.horizontal)
        }

        if let vHugging = style.vHugging {
            setContentHuggingPriority(priority(forHuggin: vHugging), for: NSLayoutConstraint.Axis.vertical)
        }

        // Resistance priority
        if let hResistance = style.hResistance {
            setContentCompressionResistancePriority(priority(forResistance: hResistance), for: NSLayoutConstraint.Axis.horizontal)
        }

        if let vResistance = style.vResistance {
            setContentCompressionResistancePriority(priority(forResistance: vResistance), for: NSLayoutConstraint.Axis.vertical)
        }

        if let tableView = self as? UIScrollView, let paddings = style.paddings {
            tableView.contentInset = paddings
        }

        if let widthScale = style.widthScale, let parentView = superview {
            autoMatchWidth(toView: parentView, withMultiplier: widthScale)
        }

        if let heightScale = style.heightScale, let parentView = superview {
            autoMatchHeight(toView: parentView, withMultiplier: heightScale)
        }

        return ViewAndLayout(view: self, style: style)
    }

    private func priority(forHuggin hugging: Hugging) -> UILayoutPriority {
        switch hugging {
        case .expand: return UILayoutPriority(rawValue: 0)
        case .hug: return UILayoutPriority.required
        case .custom(let priority): return UILayoutPriority(rawValue: priority)
        }
    }

    private func priority(forResistance resistance: Resistance) -> UILayoutPriority {
        switch resistance {
        case .allow: return UILayoutPriority(rawValue: 0)
        case .block: return UILayoutPriority.required
        case .custom(let priority): return UILayoutPriority(rawValue: priority)
        }
    }

    @discardableResult private func autoMatchWidth(
        toView: UIView,
        withMultiplier multiplier: CGFloat = 1.0,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        let layoutConstraint = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: toView,
            attribute: NSLayoutConstraint.Attribute.width,
            multiplier: multiplier,
            constant: constant
        )
        toView.addConstraint(layoutConstraint)
        return layoutConstraint
    }

    @discardableResult private func autoMatchHeight(
        toView: UIView,
        withMultiplier multiplier: CGFloat = 1.0,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        let layoutConstraint = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: toView,
            attribute: NSLayoutConstraint.Attribute.height,
            multiplier: multiplier,
            constant: constant
        )
        toView.addConstraint(layoutConstraint)
        return layoutConstraint
    }
}

extension [ViewAndLayout<UIView>] {
    @discardableResult func stackHorizontally() -> [Element] {
        Layout.stackHorizontally(self)
        return self
    }

    @discardableResult func stackVertically() -> [Element] {
        Layout.stackHorizontally(self)
        return self
    }
}

let layoutPinAll = Layout(
    left: EdgeType.pin,
    right: EdgeType.pin,
    top: EdgeType.pin,
    bottom: EdgeType.pin
)

let layoutPinAllToSafeArea = Layout(
    left: EdgeType.pinSafe,
    right: EdgeType.pinSafe,
    top: EdgeType.pinSafe,
    bottom: EdgeType.pinSafe
)

let layoutPinAllWithTopToSafeArea = Layout(
    left: EdgeType.pin,
    right: EdgeType.pin,
    top: EdgeType.pinSafe,
    bottom: EdgeType.pin
)

let layoutPinAllToSafeAreaExcludeBottom = Layout(
    left: EdgeType.pinSafe,
    right: EdgeType.pinSafe,
    top: EdgeType.pinSafe
)

let layoutPinAllToSafeAreaExcludeTop = Layout(
    left: EdgeType.pinSafe,
    right: EdgeType.pinSafe,
    bottom: EdgeType.pinSafe
)

let layoutPinTopRight = Layout(
    right: EdgeType.pin,
    top: EdgeType.pin
)

let layoutPinToSafeAreaTopRight = Layout(
    right: EdgeType.pinSafe,
    top: EdgeType.pinSafe
)

let layoutPinTopLeft = Layout(
    left: EdgeType.pin,
    top: EdgeType.pin
)

let layoutPinToSafeAreaTopLeft = Layout(
    left: EdgeType.pinSafe,
    top: EdgeType.pinSafe
)

let layoutPinBottomLeft = Layout(
    left: EdgeType.pin,
    bottom: EdgeType.pin
)

let layoutPinBottomRight = Layout(
    right: EdgeType.pin,
    bottom: EdgeType.pin
)

let layoutPinAllExcludeBottom = Layout(
    left: EdgeType.pin,
    right: EdgeType.pin,
    top: EdgeType.pin
)

let layoutPinAllExcludeTop = Layout(
    left: EdgeType.pin,
    right: EdgeType.pin,
    bottom: EdgeType.pin
)

let layoutPinAllExcludeRight = Layout(
    left: EdgeType.pin,
    top: EdgeType.pin,
    bottom: EdgeType.pin
)

let layoutPinAllExcludeLeft = Layout(
    right: EdgeType.pin,
    top: EdgeType.pin,
    bottom: EdgeType.pin
)

let layoutPinHorizontaly = Layout(
    left: EdgeType.pin,
    right: EdgeType.pin
)

let layoutPinVertically = Layout(
    top: EdgeType.pin,
    bottom: EdgeType.pin
)

let layoutCenter = Layout(
    right: EdgeType.alignToCenter,
    top: EdgeType.alignToCenter
)

let layoutTopCenterRightPin = Layout(
    right: EdgeType.pin,
    top: EdgeType.alignToCenter
)

let layoutCenterBottom = Layout(
    right: EdgeType.alignToCenter,
    bottom: EdgeType.pin
)

let layoutCenterVertically = Layout(top: EdgeType.alignToCenter)
let layoutCenterHorizontally = Layout(left: EdgeType.alignToCenter)

let layoutBottom1pxSeparator = Layout(height: 1, parent: layoutPinAllExcludeTop)
let layoutTop1pxSeparator = Layout(height: 1, parent: layoutPinAllExcludeBottom)
// Some trickery here, because contentView doesn't expand to accessoryView
let layoutCellSeparator = Layout(width: 2000, height: 1, left: EdgeType.pin, bottom: EdgeType.pin)
let layoutTopCellSeparator = Layout(width: 2000, height: 1, left: EdgeType.pin, top: EdgeType.pin)
let layoutLeftBorder = Layout(width: 1, parent: layoutPinAllExcludeRight)
let layoutRightBorder = Layout(width: 1, parent: layoutPinAllExcludeLeft)
