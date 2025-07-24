import ProjectDescription

public enum AppConfiguration {
    case debug, release

    public func appConfiguration() -> Configuration {
        switch self {
        case .debug:
            return .debug(name: configurationName, settings: settings())
        case .release:
            return .release(name: configurationName, settings: settings())
        }
    }
    
    public func appTargetConfiguration(for target: AppTarget) -> Configuration {
        switch self {
        case .debug:
            return .debug(name: configurationName, settings: targetSettings(for: target))
        case .release:
            return .release(name: configurationName, settings: targetSettings(for: target))
        }
    }
    
    private var configurationName: ConfigurationName {
        switch self {
        case .debug:
            return "Debug"
        case .release:
            return "Release"
        }
    }
    
    private func settings() -> [String: SettingValue] {
        let base: [String: SettingValue] = [
            "CODE_SIGN_STYLE": "Manual",
            "DEVELOPMENT_TEAM": "XN6K644Z23",
            "OTHER_LDFLAGS": "-ObjC",
            "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym"
        ]
        
        switch self {
        case .debug:
            let debugSettings: [String: SettingValue] = [
                "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "Debug",
            ]
            return base.merging(debugSettings, uniquingKeysWith: { _, debug in debug })
        case .release:
            let releaseSettings: [String: SettingValue] = [:]
            return base.merging(releaseSettings, uniquingKeysWith: { _, release in release })
        }
    }
    
    private func targetSettings(for target: AppTarget) -> [String: SettingValue] {
        let base: [String: SettingValue] = [
            "CODE_SIGN_IDENTITY": SettingValue(stringLiteral: target.codeSignIdentity(for: self)),
            "PROVISIONING_PROFILE_SPECIFIER": SettingValue(stringLiteral: target.provisioningProfile(for: self)),
            "GENERATE_INFOPLIST_FILE": SettingValue(booleanLiteral: target.generateInfoPlist)
        ]

        switch self {
        case .debug:
            let debugSettings: [String: SettingValue] = [:]
            return base.merging(debugSettings, uniquingKeysWith: { _, debug in debug })
        case .release:
            let releaseSettings: [String: SettingValue] = [:]
            return base.merging(releaseSettings, uniquingKeysWith: { _, release in release })
        }
    }
}

