//
//  UIButton+Style.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

extension UIButton {
    func setup(
        withTitle title: String,
        textStyle: TextStyle?,
        colorStyle: ColorStyle,
        activeColorStyle: ColorStyle? = nil
    ) {
        guard let textStyle else {
            setTitle(title, for: .normal)
            return
        }

        setAttributedTitle(
            title.attributedWith(textStyle: textStyle, customColorStyle: colorStyle),
            for: .normal
        )

        if let activeColorStyle {
            let attributedTitle = title.attributedWith(
                textStyle: textStyle,
                customColorStyle: activeColorStyle
            )
            setAttributedTitle(attributedTitle, for: .highlighted)
            setAttributedTitle(attributedTitle, for: .selected)
        }
    }

    func styleButton(_ style: CompoundStyle) {
        style.textColor.map { self.setTitleColor($0, for: UIControl.State.normal) }
        style.font.map { self.titleLabel?.font = $0 }
        style.textAlignment.map {
            self.titleLabel?.textAlignment = $0
            switch $0 {
            case .left: self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            case .right: self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
            case .center: self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            default:
                break
            }
        }
        style.numberOfLines.map { self.titleLabel?.numberOfLines = $0 }
        style.lineBreakMode.map { self.titleLabel?.lineBreakMode = $0 }
        style.adjustsFontSizeToFitWidth.map { self.titleLabel?.adjustsFontSizeToFitWidth = $0 }
    }
}
