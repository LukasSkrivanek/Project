// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Author: 
  internal static let authorLabel = L10n.tr("Localizable", "authorLabel", fallback: "Author: ")
  /// Title
  internal static let bookTitle = L10n.tr("Localizable", "bookTitle", fallback: "Title")
  /// No books found
  internal static let emptyStateText = L10n.tr("Localizable", "emptyStateText", fallback: "No books found")
  /// Loading books...
  internal static let loadingText = L10n.tr("Localizable", "loadingText", fallback: "Loading books...")
  /// Open in Google Play
  internal static let openInGooglePlay = L10n.tr("Localizable", "openInGooglePlay", fallback: "Open in Google Play")
  /// Published Year: 
  internal static let publishedDateLabel = L10n.tr("Localizable", "publishedDateLabel", fallback: "Published Year: ")
  /// Enter author
  internal static let searchPlaceholder = L10n.tr("Localizable", "searchPlaceholder", fallback: "Enter author")
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
