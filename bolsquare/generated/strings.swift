// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Common {
    /// Localizable.strings
    ///  BolSquare
    /// 
    ///   Created by Christopher Kolodziej on 23/07/2025.
    internal static let done = L10n.tr("Localizable", "Common.Done", fallback: "Done")
    /// Loading
    internal static let loading = L10n.tr("Localizable", "Common.Loading", fallback: "Loading")
  }
  internal enum Errors {
    /// Failed to load repositories.
    internal static let failedLoadRepositories = L10n.tr("Localizable", "Errors.FailedLoadRepositories.", fallback: "Failed to load repositories.")
  }
  internal enum Main {
    /// Repositories
    internal static let repositoryListTitle = L10n.tr("Localizable", "Main.RepositoryListTitle", fallback: "Repositories")
  }
  internal enum RepositoryList {
    internal enum EmptyState {
      /// Nothing here yet. Please check it out later.
      internal static let title = L10n.tr("Localizable", "RepositoryList.EmptyState.Title", fallback: "Nothing here yet. Please check it out later.")
    }
    internal enum Header {
      /// Items count: %s
      internal static func subtitle(_ p1: UnsafePointer<CChar>) -> String {
        return L10n.tr("Localizable", "RepositoryList.Header.Subtitle", p1, fallback: "Items count: %s")
      }
      /// Repositories
      internal static let title = L10n.tr("Localizable", "RepositoryList.Header.Title", fallback: "Repositories")
    }
    internal enum Owner {
      /// Owner: %s
      internal static func name(_ p1: UnsafePointer<CChar>) -> String {
        return L10n.tr("Localizable", "RepositoryList.Owner.Name", p1, fallback: "Owner: %s")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

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
