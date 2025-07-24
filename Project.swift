import ProjectDescription
import ProjectDescriptionHelpers

let appVersion = "1.0.0"
let deploymentTargetVersion = "16.0"

let destination: Destinations = [ProjectDescription.Destination.iPhone]
let deploymentTarget = DeploymentTargets.iOS(deploymentTargetVersion)
let settings: AppSettings = AppSettings(configurations: [.debug, .release])

let project = Project(
    name: "bolsquare",
    options: .options(
        automaticSchemesOptions: .disabled,
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
    ),
    packages: [
        .package(url: "https://github.com/Quick/Nimble.git", from: "13.0.0"),
        .package(url: "https://github.com/ashfurrow/Nimble-Snapshots.git", from: "9.0.0"),
    ],
    settings: .settings(
        base: ["MARKETING_VERSION": SettingValue(stringLiteral: appVersion), "CURRENT_PROJECT_VERSION": "0"],
        configurations: settings.appConfigurations(),
        defaultSettings: .recommended()
    ),
    targets: [
        .target(
            name: "bolsquare",
            destinations: destination,
            product: .app,
            bundleId: "com.chriskolodziej.bolsquare",
            deploymentTargets: deploymentTarget,
            infoPlist: .file(path: "bolsquare/supporting files/Info.plist"),
            sources: [
                "bolsquare/**/*.swift",
                "bolsquare/**/*.canBeParsed.swift",
            ],
            resources: .resources(
                [
                    "bolsquare/resources/**",
                    "bolsquare/supporting files/Colors.xcassets",
                    "bolsquare/supporting files/Images.xcassets",
                    "bolsquare/supporting files/Base.lproj/LaunchScreen.storyboard"
                ]
            ),
            scripts: [
                .pre(
                    path: "scripts/CodeGeneration/inject-grail.sh",
                    arguments: "",
                    name: "InjectGrail",
                    outputPaths: [
                        "$(SRCROOT)/bolsquare/generated/InjectGrail/RootInjector.swift",
                        "$(SRCROOT)/bolsquare/generated/InjectGrail/Injectors.swift",
                        "$(SRCROOT)/bolsquare/generated/InjectGrail/Injectables.swift"
                    ],
                    basedOnDependencyAnalysis: true
                ),
                .pre(
                    path: "scripts/CodeGeneration/sourcery.sh",
                    arguments: "",
                    name: "Sourcery",
                    outputPaths: [
                        "bolsquare/generated/Factory.canBeParsed.swift",
                        "bolsquare/generated/ContentCells.canBeParsed.swift"
                    ],
                    basedOnDependencyAnalysis: true
                ),
                .pre(
                    script: """
                    if [ $ACTION != "indexbuild" ]; then
                    scripts/CodeGeneration/swiftgen.sh
                    fi
                    """,
                    name: "SwiftGen",
                    inputPaths: [
                        "bolsquare/resources/Localizable.strings",
                        "bolsquare/supporting files/Images.xcassets",
                        "bolsquare/supporting files/Colors.xcassets"
                    ],
                    outputPaths: [
                        "bolsquare/generated/strings.swift",
                        "bolsquare/generated/images.swift",
                        "bolsquare/generated/colors.swift"
                    ],
                    basedOnDependencyAnalysis: true
                ),
                .post(
                    path: "scripts/BuildNumber/set_build_number.sh",
                    arguments: "",
                    name: "Build Number",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .external(name: "InjectGrail"),
                .external(name: "InjectGrailMacros"),
                .external(name: "Kingfisher"),
                .external(name: "MBProgressHUD")
            ],
            settings: .settings(configurations: settings.targetConfigurations(for: .bolsquare))
        ),
        .target(
            name: "bolsquareTests",
            destinations: destination,
            product: .unitTests,
            bundleId: "com.chriskolodziej.bolsquare.tests",
            deploymentTargets: deploymentTarget,
            infoPlist: .file(path: "bolsquareTests/Info.plist"),
            sources: [
                "bolsquareTests/**/*.canBeParsed.swift",
                .glob("bolsquareTests/**/*.swift", excluding: [
                    "bolsquareTests/tests/utils/fullMocks/**/*.swift",
                ])
            ],
            resources: [
                "bolsquareTests/tests/utils/testImages/*.png"
            ],
            scripts: [
                .pre(
                    path: "scripts/CodeGeneration/sourcery-tests.sh",
                    arguments: "",
                    name: "Sourcery",
                    outputPaths: [
                        "bolsquareTests/generated/Lenses.generated.swift",
                        "bolsquareTests/generated/AutoMockable.canBeParsed.swift"
                    ],
                    basedOnDependencyAnalysis: true
                ),
                .post(
                    path: "scripts/Linters/swiftlint.sh",
                    arguments: "",
                    name: "SwiftLint",
                    basedOnDependencyAnalysis: false
                ),
                .post(
                    path: "scripts/Linters/swiftformat.sh",
                    arguments: "",
                    name: "SwiftFormat",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .xctest,
                .target(name: "bolsquare"),
                .package(product: "Nimble"),
                .package(product: "Nimble-Snapshots"),
            ],
            settings: .settings(configurations: settings.targetConfigurations(for: .bolsquareTests))
        )
    ],
    schemes: [
        AppScheme.bolsquare.appScheme(),
        AppScheme.bolsquareEnvs.appScheme()
    ]
)
