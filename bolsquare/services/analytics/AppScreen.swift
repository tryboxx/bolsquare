//
//  AppScreen.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit

protocol HasAppScreen {
    var screen: AppScreen { get }
}

enum AppScreen: Equatable {
    case repositoryList
}

extension AppScreen {
    var name: String {
        switch self {
        case .repositoryList: return "repositoryList"
        }
    }

    var headerTitle: String? {
        switch self {
        case .repositoryList: return "Repositories"
        }
    }

    var title: String? {
        switch self {
        case .repositoryList: return "Repositories"
        }
    }

    var screenViewEventName: String? {
        switch self {
        case .repositoryList: return "View Repositories"
        }
    }

    var screenViewEventProperties: [String: Any]? {
        nil
    }

    var accessibilityIdentifier: String {
        "screen." + name
    }

    var statusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    var hidesTabBar: Bool {
        false
    }
}
