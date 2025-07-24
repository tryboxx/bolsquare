// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Colors {
  internal static let black = ColorAsset(name: "black")
  internal static let blue1000 = ColorAsset(name: "blue1000")
  internal static let blue200 = ColorAsset(name: "blue200")
  internal static let blue50 = ColorAsset(name: "blue50")
  internal static let clear = ColorAsset(name: "clear")
  internal static let green100 = ColorAsset(name: "green100")
  internal static let green1000 = ColorAsset(name: "green1000")
  internal static let green200 = ColorAsset(name: "green200")
  internal static let green50 = ColorAsset(name: "green50")
  internal static let green600 = ColorAsset(name: "green600")
  internal static let greenDarkShadow = ColorAsset(name: "greenDarkShadow")
  internal static let modalPickerGray = ColorAsset(name: "modalPickerGray")
  internal static let neutral100 = ColorAsset(name: "neutral100")
  internal static let neutral1000 = ColorAsset(name: "neutral1000")
  internal static let neutral200 = ColorAsset(name: "neutral200")
  internal static let neutral300 = ColorAsset(name: "neutral300")
  internal static let neutral400 = ColorAsset(name: "neutral400")
  internal static let neutral50 = ColorAsset(name: "neutral50")
  internal static let neutral500 = ColorAsset(name: "neutral500")
  internal static let neutral600 = ColorAsset(name: "neutral600")
  internal static let neutral700 = ColorAsset(name: "neutral700")
  internal static let neutral800 = ColorAsset(name: "neutral800")
  internal static let neutral900 = ColorAsset(name: "neutral900")
  internal static let orange100 = ColorAsset(name: "orange100")
  internal static let orange1000 = ColorAsset(name: "orange1000")
  internal static let orange200 = ColorAsset(name: "orange200")
  internal static let orange50 = ColorAsset(name: "orange50")
  internal static let orange600 = ColorAsset(name: "orange600")
  internal static let red100 = ColorAsset(name: "red100")
  internal static let red1000 = ColorAsset(name: "red1000")
  internal static let red200 = ColorAsset(name: "red200")
  internal static let red50 = ColorAsset(name: "red50")
  internal static let red600 = ColorAsset(name: "red600")
  internal static let teal100 = ColorAsset(name: "teal100")
  internal static let teal1000 = ColorAsset(name: "teal1000")
  internal static let teal600 = ColorAsset(name: "teal600")
  internal static let toChange = ColorAsset(name: "toChange")
  internal static let warmGray600 = ColorAsset(name: "warmGray600")
  internal static let warning = ColorAsset(name: "warning")
  internal static let white = ColorAsset(name: "white")
  internal static let whiteGradient = ColorAsset(name: "whiteGradient")
  internal static let yellow100 = ColorAsset(name: "yellow100")
  internal static let yellow1000 = ColorAsset(name: "yellow1000")
  internal static let yellow600 = ColorAsset(name: "yellow600")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
