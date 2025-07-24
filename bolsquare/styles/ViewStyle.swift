//
//  ViewStyle.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

protocol ViewStyle {}

struct TextStyle: ViewStyle {
    let font: UIFont?
    let textAlignment: NSTextAlignment?
    let numberOfLines: Int?
    let lineBreakMode: NSLineBreakMode?
    let adjustsFontSizeToFitWidth: Bool?
    let kern: CGFloat?
    let lineHeight: CGFloat?
    let underlineStyle: NSUnderlineStyle?
    let strikethroughStyle: NSUnderlineStyle?

    init(
        font: UIFont? = nil,
        textAlignment: NSTextAlignment? = nil,
        numberOfLines: Int? = nil,
        lineBreakMode: NSLineBreakMode? = nil,
        parentStyle: TextStyle? = nil,
        adjustsFontSizeToFitWidth: Bool? = nil,
        kern: CGFloat? = nil,
        lineHeight: CGFloat? = nil,
        underlineStyle: NSUnderlineStyle? = nil,
        strikethroughStyle: NSUnderlineStyle? = nil
    ) {
        self.font = font ?? parentStyle?.font
        self.textAlignment = textAlignment ?? parentStyle?.textAlignment
        self.numberOfLines = numberOfLines ?? parentStyle?.numberOfLines
        self.lineBreakMode = lineBreakMode ?? parentStyle?.lineBreakMode
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth ?? parentStyle?.adjustsFontSizeToFitWidth
        self.kern = kern ?? parentStyle?.kern
        self.lineHeight = lineHeight ?? parentStyle?.lineHeight
        self.underlineStyle = underlineStyle ?? parentStyle?.underlineStyle
        self.strikethroughStyle = strikethroughStyle ?? parentStyle?.strikethroughStyle
    }

    func oneLineOnly(lineBreakMode: NSLineBreakMode? = nil) -> TextStyle {
        TextStyle(
            font: font,
            textAlignment: textAlignment,
            numberOfLines: 1,
            lineBreakMode: lineBreakMode ?? .byTruncatingTail,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: false,
            kern: kern,
            lineHeight: nil
        )
    }

    func with(numberOfLines: Int) -> TextStyle {
        TextStyle(
            font: font,
            textAlignment: textAlignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode ?? .byTruncatingTail,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: adjustsFontSizeToFitWidth,
            kern: kern,
            lineHeight: lineHeight
        )
    }

    func with(lineBreakMode: NSLineBreakMode) -> TextStyle {
        TextStyle(
            font: font,
            textAlignment: textAlignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: adjustsFontSizeToFitWidth,
            kern: kern,
            lineHeight: lineHeight
        )
    }

    func with(lineHeight: CGFloat? = nil) -> TextStyle {
        TextStyle(
            font: font,
            textAlignment: textAlignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode ?? .byTruncatingTail,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: false,
            kern: kern,
            lineHeight: lineHeight
        )
    }

    func oneLineOnlyPreservingLineHeight() -> TextStyle {
        TextStyle(
            font: font,
            textAlignment: textAlignment,
            numberOfLines: 1,
            lineBreakMode: .byTruncatingTail,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: false,
            kern: kern,
            lineHeight: lineHeight
        )
    }

    func centered() -> TextStyle {
        TextStyle(
            font: font,
            textAlignment: .center,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: adjustsFontSizeToFitWidth,
            kern: kern,
            lineHeight: lineHeight
        )
    }

    func rightAlignement() -> TextStyle {
        TextStyle(
            font: font,
            textAlignment: .right,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: adjustsFontSizeToFitWidth,
            kern: kern,
            lineHeight: lineHeight
        )
    }

    func withFont(font: UIFont) -> TextStyle {
        TextStyle(
            font: font,
            textAlignment: textAlignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: adjustsFontSizeToFitWidth,
            kern: kern,
            lineHeight: lineHeight
        )
    }

    func withFontSize(size: CGFloat) -> TextStyle {
        TextStyle(
            font: font?.withSize(size),
            textAlignment: textAlignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: adjustsFontSizeToFitWidth,
            kern: kern,
            lineHeight: lineHeight
        )
    }

    func withUnderline() -> TextStyle {
        TextStyle(
            font: font,
            textAlignment: textAlignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: adjustsFontSizeToFitWidth,
            kern: kern,
            lineHeight: lineHeight,
            underlineStyle: .single
        )
    }

    func withStrikethrough() -> TextStyle {
        TextStyle(
            font: font,
            textAlignment: textAlignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: adjustsFontSizeToFitWidth,
            kern: kern,
            lineHeight: lineHeight,
            strikethroughStyle: .single
        )
    }

    func withAdjustingFontSizeToFitWidth() -> TextStyle {
        TextStyle(
            font: font,
            textAlignment: textAlignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode,
            parentStyle: nil,
            adjustsFontSizeToFitWidth: true,
            kern: kern,
            lineHeight: lineHeight
        )
    }
}

struct ColorStyle: ViewStyle {
    let textColor: UIColor?
    let backgroundColor: UIColor?
    let tintColor: UIColor?
    let viewAlpha: CGFloat?

    init(
        textColor: UIColor? = nil,
        backgroundColor: UIColor? = nil,
        tintColor: UIColor? = nil,
        parentStyle: ColorStyle? = nil,
        viewAlpha: CGFloat? = nil
    ) {
        self.textColor = textColor ?? parentStyle?.textColor
        self.viewAlpha = viewAlpha ?? parentStyle?.viewAlpha
        self.backgroundColor = backgroundColor ?? parentStyle?.backgroundColor
        self.tintColor = tintColor ?? parentStyle?.tintColor
    }
}

struct BorderStyle: ViewStyle {
    let borderColor: UIColor?
    let borderWidth: Float?
    let cornerRadius: Float?
    let cornerMask: CACornerMask?

    init(
        borderColor: UIColor? = nil,
        borderWidth: Float? = nil,
        cornerRadius: Float? = nil,
        cornerMask: CACornerMask? = nil,
        parentStyle: BorderStyle? = nil
    ) {

        self.borderColor = borderColor ?? parentStyle?.borderColor
        self.borderWidth = borderWidth ?? parentStyle?.borderWidth
        self.cornerRadius = cornerRadius ?? parentStyle?.cornerRadius
        self.cornerMask = cornerMask ?? parentStyle?.cornerMask
    }
}

struct ShadowStyle: ViewStyle {
    let color: UIColor?
    let opacity: Float?
    let radius: Float?
    let offset: CGSize?

    init(
        color: UIColor? = nil,
        opacity: Float? = nil,
        radius: Float? = nil,
        offset: CGSize? = nil,
        parentStyle: ShadowStyle? = nil
    ) {

        self.color = color ?? parentStyle?.color
        self.opacity = opacity ?? parentStyle?.opacity
        self.radius = radius ?? parentStyle?.radius
        self.offset = offset ?? parentStyle?.offset
    }
}

struct CompoundStyle {
    let textStyle: TextStyle?
    let colorStyle: ColorStyle?
    let borderStyle: BorderStyle?
    let shadowStyle: ShadowStyle?

    // All parameters must be forwarded to substyles
    var font: UIFont? { textStyle?.font }
    var kern: CGFloat? { textStyle?.kern }
    var lineHeight: CGFloat? { textStyle?.lineHeight }
    var textAlignment: NSTextAlignment? { textStyle?.textAlignment }
    var numberOfLines: Int? { textStyle?.numberOfLines }
    var lineBreakMode: NSLineBreakMode? { textStyle?.lineBreakMode }
    var adjustsFontSizeToFitWidth: Bool? { textStyle?.adjustsFontSizeToFitWidth }
    var underlineStyle: NSUnderlineStyle? { textStyle?.underlineStyle }
    var strikethroughStyle: NSUnderlineStyle? { textStyle?.strikethroughStyle }
    var textColor: UIColor? { colorStyle?.textColor }
    var backgroundColor: UIColor? { colorStyle?.backgroundColor }
    var borderColor: UIColor? { borderStyle?.borderColor }
    var borderWidth: Float? { borderStyle?.borderWidth }
    var cornerRadius: Float? { borderStyle?.cornerRadius }
    var cornerMask: CACornerMask? { borderStyle?.cornerMask }

    init(
        textStyle: TextStyle? = nil,
        colorStyle: ColorStyle? = nil,
        borderStyle: BorderStyle? = nil,
        shadowStyle: ShadowStyle? = nil
    ) {

        self.textStyle = textStyle
        self.colorStyle = colorStyle
        self.borderStyle = borderStyle
        self.shadowStyle = shadowStyle
    }

    /// Initializer for common scenario font + text color
    init(font: UIFont?, textColor: UIColor) {
        self.init(textStyle: TextStyle(font: font), colorStyle: ColorStyle(textColor: textColor))
    }

    /// Initializer for common scenario font + text color
    init(backgroundColor: UIColor) {
        self.init(colorStyle: ColorStyle(backgroundColor: backgroundColor))
    }

    /// Initializer for common scenario font + text color
    func withFont(font: UIFont) -> CompoundStyle {
        CompoundStyle(
            textStyle: textStyle?.withFont(font: font),
            colorStyle: colorStyle,
            borderStyle: borderStyle,
            shadowStyle: shadowStyle
        )
    }

    func rightAlignement() -> CompoundStyle {
        CompoundStyle(
            textStyle: textStyle?.rightAlignement(),
            colorStyle: colorStyle,
            borderStyle: borderStyle,
            shadowStyle: shadowStyle
        )
    }
}
