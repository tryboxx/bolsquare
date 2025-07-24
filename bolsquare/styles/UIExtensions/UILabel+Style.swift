//
//  UILabel+Style.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension UILabel {

    var styledText: String? {
        get {
            text
        }
        set {
            if let style = currentStyle, let newText = newValue {
                attributedText = newText.attributedWith(viewStyle: style)
            } else {
                text = newValue
            }
        }
    }

    convenience init(text: String? = nil, appStyle: AppStyle, customColorStyle: ColorStyle? = nil, customTextStyle: TextStyle? = nil) {
        self.init()
        setup(appStyle: appStyle, customColorStyle: customColorStyle, customTextStyle: customTextStyle)
        self.styledText = text
    }

    convenience init(attributedText: NSAttributedString, appStyle: AppStyle, customColorStyle: ColorStyle? = nil, customTextStyle: TextStyle? = nil) {
        self.init()
        setup(appStyle: appStyle, customColorStyle: customColorStyle, customTextStyle: customTextStyle)
        self.attributedText = attributedText
    }

    convenience init(text: String? = nil, viewStyle: CompoundStyle) {
        self.init()
        style(viewStyle)
        self.styledText = text
    }

    func styleLabel(_ style: CompoundStyle) {
        style.textColor.map { self.textColor = $0 }
        style.font.map { self.font = $0 }
        style.textAlignment.map { self.textAlignment = $0 }
        style.numberOfLines.map { self.numberOfLines = $0 }
        style.lineBreakMode.map { self.lineBreakMode = $0 }
        style.adjustsFontSizeToFitWidth.map { self.adjustsFontSizeToFitWidth = $0 }
    }

    func styleLabel(_ style: TextStyle) {
        style.font.map { self.font = $0 }
        style.textAlignment.map { self.textAlignment = $0 }
        style.numberOfLines.map { self.numberOfLines = $0 }
        style.lineBreakMode.map { self.lineBreakMode = $0 }
        style.adjustsFontSizeToFitWidth.map { self.adjustsFontSizeToFitWidth = $0 }
    }

    func update(withStyle style: CompoundStyle) {
        let text = styledText
        self.style(style)
        styledText = text
    }

    func setStyledText(_ text: String?, animated: Bool, animationTime: TimeInterval = 0.35) {
        guard animated else {
            styledText = text
            return
        }

        UIView.transition(
            with: self,
            duration: animationTime,
            options: .transitionCrossDissolve,
            animations: { self.styledText = text },
            completion: nil
        )
    }
}
