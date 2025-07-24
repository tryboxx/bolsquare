//
//  AppStyle.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

enum AppStyle {
    case display1
    case display2
    case display3

    case headingLarge
    case heading1
    case heading2
    case heading3

    case subtitle1
    case subtitle2
    case subtitle3

    case body1
    case body2
    case body3

    case action1
    case action2
    case action3

    case caption
    case label
    case bottomBarLabel

    case allCaps1
    case allCaps2

    case inputLarge
    case number

    case link2
    case link3
    case link4

    case completelyWhiteBackground
    case almostWhiteBackground
    case separator

    private var font: UIFont? {
        switch self {
        case .display1: return .systemFont(ofSize: 48, weight: .semibold)
        case .display2: return .systemFont(ofSize: 40, weight: .semibold)
        case .display3: return .systemFont(ofSize: 28, weight: .semibold)

        case .headingLarge: return .systemFont(ofSize: 40, weight: .semibold)
        case .heading1: return .systemFont(ofSize: 28, weight: .semibold)
        case .heading2: return .systemFont(ofSize: 24, weight: .semibold)
        case .heading3: return .systemFont(ofSize: 20, weight: .semibold)

        case .subtitle1: return .systemFont(ofSize: 18, weight: .medium)
        case .subtitle2: return .systemFont(ofSize: 16, weight: .medium)
        case .subtitle3: return .systemFont(ofSize: 14, weight: .medium)

        case .body1: return .systemFont(ofSize: 18, weight: .regular)
        case .body2: return .systemFont(ofSize: 16, weight: .regular)
        case .body3: return .systemFont(ofSize: 14, weight: .regular)

        case .action1: return .systemFont(ofSize: 18, weight: .medium)
        case .action2: return .systemFont(ofSize: 16, weight: .medium)
        case .action3: return .systemFont(ofSize: 14, weight: .medium)

        case .caption: return .systemFont(ofSize: 12, weight: .regular)
        case .label: return .systemFont(ofSize: 13, weight: .semibold)
        case .bottomBarLabel: return .systemFont(ofSize: 12, weight: .semibold)

        case .allCaps1: return .systemFont(ofSize: 13, weight: .semibold)
        case .allCaps2: return .systemFont(ofSize: 10, weight: .semibold)

        case .inputLarge: return .systemFont(ofSize: 24, weight: .regular)
        case .number: return .systemFont(ofSize: 32, weight: .regular)

        case .link2: return .systemFont(ofSize: 16, weight: .medium)
        case .link3: return .systemFont(ofSize: 14, weight: .medium)
        case .link4: return .systemFont(ofSize: 12, weight: .medium)

        default: return nil
        }
    }

    private var lineHeight: CGFloat? {
        switch self {
        case .display1: return 48
        case .display2: return 40
        case .display3: return 28

        case .headingLarge: return 40
        case .heading1: return 32
        case .heading2: return 28
        case .heading3: return 24

        case .subtitle1: return 26
        case .subtitle2: return 24
        case .subtitle3: return 22

        case .body1: return 26
        case .body2: return 24
        case .body3: return 22

        case .action1: return 24
        case .action2: return 24
        case .action3: return 24

        case .caption: return 16
        case .label: return 16
        case .bottomBarLabel: return 16

        case .allCaps1: return 16
        case .allCaps2: return 16

        case .inputLarge: return 32
        case .number: return 32

        case .link2: return 24
        case .link3: return 22
        case .link4: return 16

        default: return nil
        }
    }

    private var kern: CGFloat? {
        switch self {
        case .caption: return 0.12
        case .label: return -0.12

        case .allCaps1: return 0.26
        case .allCaps2: return 0.23

        case .inputLarge: return 0.12

        case .link3: return 0.12

        default: return nil
        }
    }

    var textStyle: TextStyle? {
        switch self {
        case .completelyWhiteBackground, .almostWhiteBackground, .separator: return nil
        default:
            return TextStyle(
                font: font,
                textAlignment: .left,
                numberOfLines: 0,
                lineBreakMode: .byWordWrapping,
                parentStyle: nil,
                adjustsFontSizeToFitWidth: false,
                kern: kern,
                lineHeight: lineHeight
            )
        }
    }

    private var textColor: UIColor? {
        switch self {
        case .completelyWhiteBackground, .almostWhiteBackground, .separator: return nil
        default: return Colors.green1000.color
        }
    }

    private var backgroundColor: UIColor? {
        switch self {
        case .completelyWhiteBackground: return Colors.white.color
        case .almostWhiteBackground:  return Colors.neutral50.color
        case .separator: return Colors.neutral200.color
        default: return nil
        }
    }

    var colorStyle: ColorStyle? {
        ColorStyle(
            textColor: textColor,
            backgroundColor: backgroundColor
        )
    }

    var viewStyle: CompoundStyle {
        CompoundStyle(
            textStyle: textStyle,
            colorStyle: colorStyle
        )
    }
}

extension AppStyle {

    func with(textColor: UIColor) -> CompoundStyle {
        CompoundStyle(
            textStyle: textStyle,
            colorStyle: ColorStyle(textColor: textColor)
        )
    }
}
