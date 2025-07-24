//
//  AppUI.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import Foundation

enum AppUI {

    static var animationsEnabled: Bool { dependencies?.animationsEnabled ?? false }

    private(set) static var dependencies: CrossDependencies?

    static func initialize(with dependencies: CrossDependencies) {
        self.dependencies = dependencies
    }
}
