//
//  TextDefinition.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

class TextDefinition: ContentItemDefinition {
    let type = ContentItemType.text
    let content: TextDefinitionContent
    let insets: UIEdgeInsets?

    init(
        text: String,
        textAlignment: NSTextAlignment? = nil,
        style: AppStyle? = nil,
        insets: UIEdgeInsets? = nil
    ) {
        self.content = TextDefinitionContent.styled(
            StyledTextDefinition(
                text: text,
                textAlignment: textAlignment,
                textStyle: style?.textStyle,
                colorStyle: style?.colorStyle
            )
        )
        self.insets = insets
    }

    init(
        text: String,
        viewStyle: CompoundStyle,
        insets: UIEdgeInsets? = nil
    ) {
        self.content = TextDefinitionContent.styled(
            StyledTextDefinition(
                text: text,
                textAlignment: nil,
                textStyle: viewStyle.textStyle,
                colorStyle: viewStyle.colorStyle
            )
        )
        self.insets = insets
    }

    init(
        text: String,
        textAlignment: NSTextAlignment? = nil,
        textStyle: TextStyle? = nil,
        colorStyle: ColorStyle? = nil,
        insets: UIEdgeInsets? = nil
    ) {
        self.content = TextDefinitionContent.styled(
            StyledTextDefinition(
                text: text,
                textAlignment: textAlignment,
                textStyle: textStyle,
                colorStyle: colorStyle
            )
        )
        self.insets = insets
    }

    init(
        attributedText: NSAttributedString,
        numberOfLines: Int? = nil,
        lineBreakMode: NSLineBreakMode? = nil,
        insets: UIEdgeInsets? = nil
    ) {
        self.content = TextDefinitionContent.attributed(
            AttributedTextDefinition(
                attributedText: attributedText,
                numberOfLines: numberOfLines,
                lineBreakMode: lineBreakMode
            )
        )
        self.insets = insets
    }
}

enum TextDefinitionContent {
    case styled(StyledTextDefinition)
    case attributed(AttributedTextDefinition)
}

struct StyledTextDefinition {
    let text: String
    let textAlignment: NSTextAlignment?
    let textStyle: TextStyle?
    let colorStyle: ColorStyle?
}

struct AttributedTextDefinition {
    let attributedText: NSAttributedString?
    let numberOfLines: Int?
    let lineBreakMode: NSLineBreakMode?
}
