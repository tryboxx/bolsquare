import ProjectDescription

public struct AppSettings {
    private let configurations: [AppConfiguration]
    
    public func appConfigurations() -> [Configuration] {
        configurations.map { $0.appConfiguration() }
    }
    
    public func targetConfigurations(for target: AppTarget) -> [Configuration] {
        configurations.map { $0.appTargetConfiguration(for: target) }
    }
    
    public init(configurations: [AppConfiguration]) {
        self.configurations = configurations
    }
}
