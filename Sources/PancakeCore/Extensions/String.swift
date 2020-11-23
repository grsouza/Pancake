import Foundation

extension String {
  /// Creates a string from the `dump` output of the given value.
  public init<T>(dumping value: T) {
    self.init()
    dump(value, to: &self)
  }

  /// Current string casted as a `NSString`.
  public var nsString: NSString { self as NSString }

  /// Returns a substring in the `NSRange` provided.
  public func substring(with nsRange: NSRange) -> String {
    nsString.substring(with: nsRange)
  }
}
