//
//  String+Style.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension String {
    func attributedWith(appStyle: AppStyle) -> NSAttributedString {
        attributedWith(
            font: appStyle.viewStyle.font,
            color: appStyle.viewStyle.textColor,
            kern: appStyle.viewStyle.kern,
            lineHeight: appStyle.viewStyle.lineHeight,
            alignment: appStyle.viewStyle.textAlignment,
            lineBreakMode: appStyle.viewStyle.lineBreakMode,
            underline: appStyle.viewStyle.underlineStyle,
            strikethrough: appStyle.viewStyle.strikethroughStyle
        )
    }

    func attributedWith(viewStyle: CompoundStyle, customColorStyle: ColorStyle? = nil) -> NSAttributedString {
        attributedWith(
            font: viewStyle.font,
            color: customColorStyle?.textColor ?? viewStyle.textColor,
            kern: viewStyle.kern,
            lineHeight: viewStyle.lineHeight,
            alignment: viewStyle.textAlignment,
            lineBreakMode: viewStyle.lineBreakMode,
            underline: viewStyle.underlineStyle,
            strikethrough: viewStyle.strikethroughStyle
        )
    }

    func attributedWith(textStyle: TextStyle, customColorStyle: ColorStyle? = nil) -> NSAttributedString {
        attributedWith(
            font: textStyle.font,
            color: customColorStyle?.textColor,
            kern: textStyle.kern,
            lineHeight: textStyle.lineHeight,
            alignment: textStyle.textAlignment,
            lineBreakMode: textStyle.lineBreakMode,
            underline: textStyle.underlineStyle,
            strikethrough: textStyle.strikethroughStyle
        )
    }
}
