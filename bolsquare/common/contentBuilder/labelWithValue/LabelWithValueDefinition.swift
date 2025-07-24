//
//  LabelWithValueDefinition.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

class LabelWithValueDefinition: ContentItemDefinition, HasDynamicHeight {
    let type = ContentItemType.labelWithValue
    let name: String
    let value: String
    let customNameStyle: CompoundStyle?
    let customValueStyle: CompoundStyle?
    let hideSeparator: Bool

    var onHeightChanged: (() -> Void)?

    init(name: String, value: String, customNameStyle: CompoundStyle? = nil, customValueStyle: CompoundStyle? = nil, hideSeparator: Bool = false) {
        self.name = name
        self.value = value
        self.customNameStyle = customNameStyle
        self.customValueStyle = customValueStyle
        self.hideSeparator = hideSeparator
    }
}
