//
//  UIView+Style.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

private var styleKey = "UIViewStyleKey"

extension UIView {

    var currentStyle: CompoundStyle? {
        withUnsafePointer(to: &styleKey) {
            objc_getAssociatedObject(self, $0) as? CompoundStyle
        }
    }

    @discardableResult func setup(appStyle: AppStyle, customColorStyle: ColorStyle? = nil, customTextStyle: TextStyle? = nil) -> Self {
        style(CompoundStyle(textStyle: customTextStyle ?? appStyle.textStyle, colorStyle: customColorStyle ?? appStyle.colorStyle))
        return self
    }

    func withStyle(_ style: CompoundStyle) -> Self {
        self.style(style)
        return self
    }

    func withStyle(_ style: ViewStyle) -> Self {
        self.style(style)
        return self
    }

    func style(_ style: CompoundStyle) {

        withUnsafePointer(to: &styleKey) {
            objc_setAssociatedObject(self, $0, style, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }

        style.backgroundColor.map { self.backgroundColor = $0 }
        style.borderColor.map { self.layer.borderColor = $0.cgColor }
        style.borderWidth.map { self.layer.borderWidth = CGFloat($0) }
        style.cornerRadius.map { self.layer.cornerRadius = CGFloat($0) }
        style.cornerMask.map { self.layer.maskedCorners = $0 }
        (style.colorStyle?.viewAlpha).map { self.alpha = $0 }
        style.shadowStyle.map { self.style(shadowStyle: $0) }
        (style.colorStyle?.tintColor).map { self.tintColor = $0 }

        switch self {
        case let textField as UITextField: textField.styleTextField(style)
        case let label as UILabel: label.styleLabel(style)
        case let button as UIButton: button.styleButton(style)
        default: break
        }
    }

    func style(_ styles: CompoundStyle...) {
        styles.forEach { self.style($0) }
    }

    func style(_ styles: [CompoundStyle]) {
        styles.forEach { self.style($0) }
    }

    func style(_ styles: ViewStyle...) {
        style(styles)
    }

    func style(_ styles: [ViewStyle]) {
        for item in styles {
            switch item {
            case let style as TextStyle: self.style(CompoundStyle(textStyle: style))
            case let style as ColorStyle: self.style(CompoundStyle(colorStyle: style))
            case let style as BorderStyle: self.style(CompoundStyle(borderStyle: style))
            default: break
            }
        }
    }

    func style(shadowStyle: ShadowStyle) {
        layer.style(shadowStyle: shadowStyle)
    }
}

extension CALayer {
    func style(shadowStyle: ShadowStyle) {
        shadowStyle.color.map { shadowColor = $0.cgColor }
        shadowStyle.opacity.map { shadowOpacity = $0 }
        shadowStyle.radius.map { shadowRadius = CGFloat($0) }
        shadowStyle.offset.map { shadowOffset = $0 }
    }
}
