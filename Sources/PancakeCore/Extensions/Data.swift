import Foundation

extension Data {
  /// Returns data as an Array of 8-bit unsigned integer.
  public var bytes: [UInt8] {
    [UInt8](self)
  }

  /// Return `Data` encoded as a `String` using the given encoding.
  /// - Parameter encoding: Encoding to use.
  /// - Returns: String representation of `Data` or `nil` if it failed.
  public func string(encoding: String.Encoding) -> String? {
    String(data: self, encoding: encoding)
  }

  /// Returns a Foundation object from given JSON data.
  ///
  /// The data must be in one of the 5 supported encodings listed in the JSON specification: UTF-8, UTF-16LE, UTF-16BE, UTF-32LE, UTF-32BE. The data may or may not have a BOM. The most efficient encoding to use for parsing is UTF-8, so if you have a choice in encoding the data passed to this method, use UTF-8.
  /// - Parameter options: Options for reading the JSON data and creating the Foundation objects. For possible values, see [JSONSerialization.ReadingOptions](https://developer.apple.com/documentation/foundation/jsonserialization/readingoptions).
  public func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
    try JSONSerialization.jsonObject(with: self, options: options)
  }
}
