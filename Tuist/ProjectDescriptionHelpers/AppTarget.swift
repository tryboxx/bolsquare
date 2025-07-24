import ProjectDescription

public enum AppTarget {
    case bolsquare, bolsquareTests, bolsquareUITests

    var name: String {
        switch self {
        case .bolsquare: return "bolsquare"
        case .bolsquareTests: return "bolsquareTests"
        case .bolsquareUITests: return "bolsquareUITests"
        }
    }

    var generateInfoPlist: Bool {
        return false
    }

    public func codeSignIdentity(for configuration: AppConfiguration) -> String {
        switch (self, configuration) {
        case (.bolsquare, _): return "Apple Development"
        case (.bolsquareUITests, _): return "Apple Development"
        case (_, .debug): return "Apple Development"
        case (_, .release): return "Apple Distribution"
        }
    }

    public func provisioningProfile(for configuration: AppConfiguration) -> String {
        switch (self, configuration) {
        case (.bolsquare, .debug): return "bolsquare-develop"
        case (.bolsquare, .release): return "bolsquare-appstore-release"
        case (.bolsquareTests, _): return ""
        case (.bolsquareUITests, _): return "bolsquare-xcuitests"
        }
    }
}
