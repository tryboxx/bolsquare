//
//  HeaderDefinition.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

class HeaderDefinition: ContentItemDefinition, HasDynamicHeight {
    let type = ContentItemType.header
    let title: String
    let hint: String?
    let style: HeaderStyle

    var isHintShown = false
    var canShowHint: Bool {
        !(hint ?? "").isEmpty
    }

    var onHeightChanged: (() -> Void)?

    init(title: String, hint: String? = nil, style: HeaderStyle = .regular) {
        self.title = title
        self.hint = hint
        self.style = style
    }
}
