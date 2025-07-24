//
//  EmptyDefinition.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import Foundation

class EmptyDefinition: ContentItemDefinition {
    let type = ContentItemType.empty
    let height: CGFloat

    init(withHeight height: CGFloat = 40.0) {
        self.height = height
    }
}
