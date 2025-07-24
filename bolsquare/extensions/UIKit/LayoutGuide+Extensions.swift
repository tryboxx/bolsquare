//
//  LayoutGuide+Extensions.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

public protocol LayoutGuide {
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }

    var heightAnchor: NSLayoutDimension { get }
    var widthAnchor: NSLayoutDimension { get }

    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }

    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: LayoutGuide {

    func updatePosition(x: CGFloat, y: CGFloat) {
        guard let superview else { return }

        let positionConstraints = superview.constraints.filter {
            $0.firstItem === self && ($0.firstAttribute == .left || $0.firstAttribute == .top)
        }

        NSLayoutConstraint.deactivate(positionConstraints)

        pinEdge(.left, to: superview, offset: x)
        pinEdge(.top, to: superview, offset: y)
    }

    func updateSize(width: CGFloat, height: CGFloat) {
        let sizeConstraints = constraints.filter {
            ($0.firstAttribute == .width || $0.firstAttribute == .height) && $0.secondItem == nil
        }

        NSLayoutConstraint.deactivate(sizeConstraints)

        setSize(width: width, height: height)
    }
}

extension UILayoutGuide: LayoutGuide {}

extension LayoutGuide {

    func pinEdges(_ edges: UIRectEdge = .all, to layoutGuide: LayoutGuide, insets: UIEdgeInsets = .zero, priority: UILayoutPriority? = nil) {
        let topConstraint = edges.contains(.top) ? topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top) : nil
        let leftConstraint = edges.contains(.left) ? leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left) : nil
        let rightConstraint = edges.contains(.right) ? rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -insets.right) : nil
        let bottomConstraint = edges.contains(.bottom) ? bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom) : nil

        let constraints = [topConstraint, leftConstraint, rightConstraint, bottomConstraint].compactMap { $0 }

        if let priority {
            constraints.forEach { $0.prioritize(priority) }
        }

        NSLayoutConstraint.activate(constraints)
    }

    func pinEdge(_ edge: UIRectEdge, to layoutGuide: LayoutGuide, offset: CGFloat = 0) {
        var constraints = [NSLayoutConstraint]()
        switch edge {
        case .left: constraints.append(leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: offset))
        case .right: constraints.append(rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -offset))
        case .top: constraints.append(topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: offset))
        case .bottom: constraints.append(bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -offset))
        case .all:
            constraints.append(leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: offset))
            constraints.append(rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -offset))
            constraints.append(topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: offset))
            constraints.append(bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -offset))
        default: break
        }

        NSLayoutConstraint.activate(constraints)
    }

    func pinEdgeToBeLessThanOrEqualTo(_ edge: UIRectEdge, to layoutGuide: LayoutGuide, offset: CGFloat = 0) {
        var constraints = [NSLayoutConstraint]()
        switch edge {
        case .left: constraints.append(leftAnchor.constraint(lessThanOrEqualTo: layoutGuide.leftAnchor, constant: offset))
        case .right: constraints.append(rightAnchor.constraint(lessThanOrEqualTo: layoutGuide.rightAnchor, constant: -offset))
        case .top: constraints.append(topAnchor.constraint(lessThanOrEqualTo: layoutGuide.topAnchor, constant: offset))
        case .bottom: constraints.append(bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor, constant: -offset))
        case .all:
            constraints.append(leftAnchor.constraint(lessThanOrEqualTo: layoutGuide.leftAnchor, constant: offset))
            constraints.append(rightAnchor.constraint(lessThanOrEqualTo: layoutGuide.rightAnchor, constant: -offset))
            constraints.append(topAnchor.constraint(lessThanOrEqualTo: layoutGuide.topAnchor, constant: offset))
            constraints.append(bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor, constant: -offset))
        default: break
        }

        NSLayoutConstraint.activate(constraints)
    }

    func pinEdgeToBeGreaterThanOrEqualTo(_ edge: UIRectEdge, to layoutGuide: LayoutGuide, offset: CGFloat = 0) {
        var constraints = [NSLayoutConstraint]()
        switch edge {
        case .left: constraints.append(leftAnchor.constraint(greaterThanOrEqualTo: layoutGuide.leftAnchor, constant: offset))
        case .right: constraints.append(rightAnchor.constraint(greaterThanOrEqualTo: layoutGuide.rightAnchor, constant: -offset))
        case .top: constraints.append(topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor, constant: offset))
        case .bottom: constraints.append(bottomAnchor.constraint(greaterThanOrEqualTo: layoutGuide.bottomAnchor, constant: -offset))
        case .all:
            constraints.append(leftAnchor.constraint(greaterThanOrEqualTo: layoutGuide.leftAnchor, constant: offset))
            constraints.append(rightAnchor.constraint(greaterThanOrEqualTo: layoutGuide.rightAnchor, constant: -offset))
            constraints.append(topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor, constant: offset))
            constraints.append(bottomAnchor.constraint(greaterThanOrEqualTo: layoutGuide.bottomAnchor, constant: -offset))
        default: break
        }

        NSLayoutConstraint.activate(constraints)
    }

    func pinEdge(_ edge: UIRectEdge, to opositeEdge: UIRectEdge, of layoutGuide: LayoutGuide, offset: CGFloat = 0) {
        var constraints = [NSLayoutConstraint]()
        var anchor1X: NSLayoutXAxisAnchor?
        var anchor1Y: NSLayoutYAxisAnchor?
        var anchor2X: NSLayoutXAxisAnchor?
        var anchor2Y: NSLayoutYAxisAnchor?

        switch edge {
        case .left: anchor1X = leftAnchor
        case .right: anchor1X = rightAnchor
        case .top: anchor1Y = topAnchor
        case .bottom: anchor1Y = bottomAnchor
        default: break
        }

        switch opositeEdge {
        case .left: anchor2X = layoutGuide.leftAnchor
        case .right: anchor2X = layoutGuide.rightAnchor
        case .top: anchor2Y = layoutGuide.topAnchor
        case .bottom: anchor2Y = layoutGuide.bottomAnchor
        default: break
        }

        if let anchor1X, let anchor2X {
            constraints.append(anchor1X.constraint(equalTo: anchor2X, constant: offset))
        } else if let anchor1Y, let anchor2Y {
            constraints.append(anchor1Y.constraint(equalTo: anchor2Y, constant: offset))
        } else {
            fatalError("Failed to constraint edges \(edge) and \(opositeEdge)")
        }

        NSLayoutConstraint.activate(constraints)
    }

    func pinEdge(_ edge: UIRectEdge, toOpposite layoutGuide: LayoutGuide, offset: CGFloat = 0) {
        var constraints = [NSLayoutConstraint]()
        switch edge {
        case .left: constraints.append(leftAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: offset))
        case .right: constraints.append(rightAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: -offset))
        case .top: constraints.append(topAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: offset))
        case .bottom: constraints.append(bottomAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: -offset))
        case .all: fatalError("not possible to pin to all opposite edges")
        default: break
        }

        NSLayoutConstraint.activate(constraints)
    }

    func pinEdgeToBeLessThanOrEqualTo(_ edge: UIRectEdge, toOpposite layoutGuide: LayoutGuide, offset: CGFloat = 0) {
        var constraints = [NSLayoutConstraint]()
        switch edge {
        case .left: constraints.append(leftAnchor.constraint(lessThanOrEqualTo: layoutGuide.rightAnchor, constant: offset))
        case .right: constraints.append(rightAnchor.constraint(lessThanOrEqualTo: layoutGuide.leftAnchor, constant: -offset))
        case .top: constraints.append(topAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor, constant: offset))
        case .bottom: constraints.append(bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.topAnchor, constant: -offset))
        case .all: fatalError("not possible to pin to all opposite edges")
        default: break
        }

        NSLayoutConstraint.activate(constraints)
    }

    func edgeConstraint(_ edge: UIRectEdge, layoutGuide: LayoutGuide, offset: CGFloat = 0) -> NSLayoutConstraint? {
        switch edge {
        case .left: return leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: offset)
        case .right: return rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -offset)
        case .top: return topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: offset)
        case .bottom: return bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -offset)
        case .all: return nil
        default: return nil
        }
    }

    func edgeConstraint(_ edge: UIRectEdge, toOpposite layoutGuide: LayoutGuide, offset: CGFloat = 0) -> NSLayoutConstraint? {
        switch edge {
        case .left: return leftAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: offset)
        case .right: return rightAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: -offset)
        case .top: return topAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: offset)
        case .bottom: return bottomAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: -offset)
        case .all: return nil
        default: return nil
        }
    }

    func pinEdge(_ edge: UIRectEdge, layoutGuide: LayoutGuide, offset: CGFloat = 0) -> NSLayoutConstraint? {
        guard let constraint = edgeConstraint(edge, layoutGuide: layoutGuide, offset: offset) else {
            return nil
        }
        constraint.activate()
        return constraint
    }

    func center(in layoutGuide: LayoutGuide, offset: CGPoint = .zero) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor, constant: offset.x),
            centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor, constant: offset.y)
        ])
    }

    func centerY(in layoutGuide: LayoutGuide, offset: CGFloat = 0) {
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor, constant: offset)
        ])
    }

    func centerX(in layoutGuide: LayoutGuide, offset: CGFloat = 0) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor, constant: offset)
        ])
    }

    func setSize(_ size: CGSize) {
        setSize(width: size.width, height: size.height)
    }

    func setSize(width: CGFloat, height: CGFloat) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }

    @discardableResult func setHeight(height: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalToConstant: height)
        if let priority {
            constraint.priority = priority
        }
        NSLayoutConstraint.activate([
            constraint
        ])
        return constraint
    }

    func setWidth(width: CGFloat) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width)
        ])
    }

    func matchWidth(of referenceView: UIView, inset: CGFloat = 0) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: referenceView.widthAnchor, constant: -inset)
        ])
    }

    func matchHeight(of referenceView: UIView) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: referenceView.heightAnchor)
        ])
    }

    func matchMinHeight(to referenceView: UIView) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualTo: referenceView.heightAnchor)
        ])
    }
}

extension UIView {
    func pinParentEdge(_ edge: UIRectEdge, offset: CGFloat = 0) -> NSLayoutConstraint? {
        guard let parent = superview,
              let constraint = edgeConstraint(edge, layoutGuide: parent, offset: offset) else {
            return nil
        }
        constraint.activate()
        return constraint
    }

    func pinParentEdges(withContentInsets contentInsets: ContentInsets) -> LayoutConstraints {
        let result = LayoutConstraints()
        result.left = pinParentEdge(.left, offset: contentInsets.leftInset)
        result.right = pinParentEdge(.right, offset: contentInsets.rightInset)
        result.top = pinParentEdge(.top, offset: contentInsets.topInset)
        result.bottom = pinParentEdge(.bottom, offset: contentInsets.bottomInset)
        return result
    }
}
