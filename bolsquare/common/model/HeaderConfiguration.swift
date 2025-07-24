//
//  HeaderConfiguration.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation

typealias HeaderActionBlock = () -> Void

enum HeaderType {
    case regular
    case compact
}

enum HeaderColorMode {
    case dark
    case light
}

@MainActor
final class HeaderConfiguration {
    let type: HeaderType
    let title: String?
    var colorMode: HeaderColorMode?

    var backAction: HeaderActionBlock?
    var closeAction: HeaderActionBlock?

    init(
        type: HeaderType,
        title: String? = nil,
        colorMode: HeaderColorMode? = nil,
        backAction: HeaderActionBlock? = nil,
        closeAction: HeaderActionBlock? = nil
    ) {
        self.type = type
        self.title = title
        self.colorMode = colorMode
        self.backAction = backAction
        self.closeAction = closeAction
    }
}

extension HeaderConfiguration {
    static func regular(title: String? = nil) -> HeaderConfiguration {
        HeaderConfiguration(type: .regular, title: title)
    }

    static func compact(title: String? = nil) -> HeaderConfiguration {
        HeaderConfiguration(type: .compact, title: title)
    }
}
