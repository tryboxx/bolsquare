//
//  AppUtils.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

class AppUtils {

    static func versionString() -> String? {
        if let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String,
            let build = dictionary["CFBundleVersion"] as? String {
            return "\(version) (\(build))"
        }
        return nil
    }

    static func mainVersionString() -> String? {
        guard let dictionary = Bundle.main.infoDictionary else { return nil }
        return dictionary["CFBundleShortVersionString"] as? String
    }

    static func buildVersionString() -> String? {
        guard let dictionary = Bundle.main.infoDictionary else { return nil }
        return dictionary["CFBundleVersion"] as? String
    }

    static func isRunningTests() -> Bool {
        NSClassFromString("XCTestCase") != nil
    }
}
