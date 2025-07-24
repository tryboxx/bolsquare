//
//  HeaderStyle.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

private enum Styles {
    static let largeTitle = AppStyle.heading2
    static let regularTitle = AppStyle.heading3
    static let smallTitle = AppStyle.subtitle1
}

enum HeaderStyle {
    case regular
    case small
    case large

    var appStyle: AppStyle {
        switch self {
        case .regular: return Styles.regularTitle
        case .small: return Styles.smallTitle
        case .large: return Styles.largeTitle
        }
    }
}
