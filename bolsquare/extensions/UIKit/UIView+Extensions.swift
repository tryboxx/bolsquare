//
//  UIView+Extensions.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension UIView {
    var safeAreaLayoutGuideWrapper: LayoutGuide {
        guard #available(iOS 11.0, *) else {
            return self
        }

        return safeAreaLayoutGuide
    }

    var safeAreaInsetsWrapper: UIEdgeInsets {
        guard #available(iOS 11.0, *) else {
            return .zero
        }

        return safeAreaInsets
    }

    @discardableResult func withoutResizingMask() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview(_:))
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(addSubview(_:))
    }

    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    func removeAllSubviewsRecursively(except: UIView? = nil) {
        subviews.forEach {
            guard $0 !== except else { return }
            if let wantToDecideAboutChildrenRemoval = $0 as? AwareOfRecursiveRemoval {
                if wantToDecideAboutChildrenRemoval.canRemoveChildrenRecursively() {
                    $0.removeAllSubviewsRecursively(except: except)
                }
            } else {
                $0.removeAllSubviewsRecursively(except: except)
            }

            $0.removeFromSuperview()
        }
    }

    func isKindOfOrDescendantOfKind(aClass: AnyClass) -> Bool {
        guard isKind(of: aClass) == false else { return true }

        return superview?.isKindOfOrDescendantOfKind(aClass: aClass) ?? false
    }

    func findParentOfKind<T: AnyObject>(aClass: T.Type) -> T? {
        guard isKind(of: aClass) == false else { return self as? T }

        return superview?.findParentOfKind(aClass: aClass)
    }

    func findParent<T>(ofType type: T.Type) -> T? {
        if let match = self as? T {
            return match
        }
        var parent = superview
        while let currentParent = parent {
            if let match = currentParent as? T {
                return match
            }
            parent = currentParent.superview
        }
        return nil
    }
}

extension UIView {
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
}

extension UIView {
    func removeSelfConstraints() {
        let superviewConstraints = superview?.constraints.filter {
            $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
        } ?? []

        let selfConstraints = constraints.filter {
            ($0.firstItem as? UIView == self && $0.secondItem as? UIView == self) ||
            ($0.firstItem as? UIView == self && $0.secondItem as? UIView == nil) ||
            ($0.firstItem as? UIView == nil && $0.secondItem as? UIView == self)
        }

        superview?.removeConstraints(superviewConstraints)
        removeConstraints(selfConstraints)
    }
}

protocol AwareOfRecursiveRemoval {
    func canRemoveChildrenRecursively() -> Bool
}
