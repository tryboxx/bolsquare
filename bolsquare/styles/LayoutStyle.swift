//
//  LayoutStyle.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

enum ContentInsets {
    case common
    case custom(UIEdgeInsets)
    case zero

    static let commonInset = CGFloat(16)

    var insets: UIEdgeInsets {
        switch self {
        case .custom(let insets): return insets
        default: return UIEdgeInsets(left: leftInset, right: rightInset)
        }
    }

    var leftInset: CGFloat {
        switch self {
        case .common: return ContentInsets.commonInset
        case .custom(let insets): return insets.left
        case .zero: return CGFloat(0)
        }
    }

    var rightInset: CGFloat {
        switch self {
        case .common: return ContentInsets.commonInset
        case .custom(let insets): return insets.right
        case .zero: return CGFloat(0)
        }
    }

    var topInset: CGFloat {
        switch self {
        case .custom(let insets): return insets.top
        default: return CGFloat(0)
        }
    }

    var bottomInset: CGFloat {
        switch self {
        case .custom(let insets): return insets.bottom
        default: return CGFloat(0)
        }
    }

    var leftAndRightInsets: CGFloat {
        leftInset + rightInset
    }
}
