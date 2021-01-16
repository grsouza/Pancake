//
//  File.swift
//
//
//  Created by Guilherme Souza on 16/01/21.
//

import Foundation

public struct EmailAddress: RawRepresentable, Codable {

  // MARK: Lifecycle

  public init?(rawValue: String) {
    let value = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)

    if !Self.isEmail(value) {
      return nil
    }

    self.rawValue = value
  }

  // MARK: Public

  public var rawValue: String

  // MARK: Private

  private static func isEmail(_ string: String) -> Bool {

    let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)

    let range = NSRange(
      string.startIndex ..< string.endIndex,
      in: string
    )

    let matches = detector?.matches(
      in: string,
      options: [],
      range: range
    )

    // We only want our string to contain a single email
    // address, so if multiple matches were found, then
    // we fail our validation process and return nil:
    guard let match = matches?.first, matches?.count == 1 else {
      return false
    }

    // Verify that the found link points to an email address,
    // and that its range covers the whole input string:
    guard match.url?.scheme == "mailto", match.range == range else {
      return false
    }

    return true
  }
}
