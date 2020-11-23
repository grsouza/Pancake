//
//  File.swift
//
//
//  Created by Guilherme Souza on 20/11/20.
//

import Foundation

public protocol DefaultDecodable: Decodable {
  static var defaultValue: Self { get }
}

extension DefaultDecodable where Self: RawRepresentable, Self.RawValue == String {
  public init(from decoder: Decoder) throws {
    let rawString = try decoder.singleValueContainer().decode(String.self)

    if let value = Self.init(rawValue: rawString) {
      self = value
    } else {
      self = Self.defaultValue
    }
  }
}
