//
//  SeparatorDefinition.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation

class SeparatorDefinition: ContentItemDefinition {
    let type = ContentItemType.separator
    let height: CGFloat?

    init(withHeight height: CGFloat = 1.0) {
        self.height = height
    }
}
