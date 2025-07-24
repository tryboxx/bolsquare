//
//  ContentItemDefinition.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

@MainActor
protocol ContentItemDefinition {
    var type: ContentItemType { get }
    var customContentInsets: ContentInsets? { get }
}

extension ContentItemDefinition {
    var customContentInsets: ContentInsets? { nil }
}

extension ContentItemType {
    var emptyDefinition: ContentItemDefinition {
        EmptyContentDefinition(type: self)
    }
}

struct EmptyContentDefinition: ContentItemDefinition {
    let type: ContentItemType
}

extension [ContentItemDefinition] {

    @MainActor
    func withSeparators() -> [ContentItemDefinition] {
        Array(map { [$0] }.joined(separator: [SeparatorDefinition()]))
    }

    @MainActor
    func withSpacers(height: CGFloat = 16) -> [ContentItemDefinition] {
        Array(map { [$0] }.joined(separator: [EmptyDefinition(withHeight: height)]))
    }
}
