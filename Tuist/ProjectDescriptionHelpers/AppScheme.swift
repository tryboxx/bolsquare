import ProjectDescription

public enum AppScheme {
    case bolsquare, bolsquareEnvs

    private var schemeName: String {
        switch self {
        case .bolsquare: return "bolsquare"
        case .bolsquareEnvs: return "bolsquareEnvs"
        }
    }

    private var buildAction: BuildAction? {
        return .buildAction(targets: ["bolsquare"])
    }

    private var runAction: RunAction? {
        return .runAction(executable: "bolsquare", options: .options(language: "en"))
    }

    private var testAction: TestAction? {
        return .targets(["bolsquareTests"], options: testOptions)
    }

    private var testOptions: TestActionOptions {
        .options(
            language: "en",
            region: "US",
            coverage: true,
            codeCoverageTargets: ["bolsquare"]
        )
    }

    private var archiveAction: ArchiveAction? {
        return nil
    }

    private var profileAction: ProfileAction? {
        return nil
    }

    public func appScheme() -> Scheme {
        .scheme(name: schemeName,
                shared: true,
                buildAction: buildAction,
                testAction: testAction,
                runAction: runAction,
                archiveAction: archiveAction,
                profileAction: profileAction
        )
    }
}
