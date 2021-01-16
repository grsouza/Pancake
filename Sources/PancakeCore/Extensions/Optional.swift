import Foundation

extension Optional {
  /// Unwrap Optional if it has some value, otherwise throw the error.
  @inlinable
  public func unwrap(
    or error: @autoclosure () -> Swift.Error
  ) throws -> Wrapped {
    guard let wrapped = self else {
      throw error()
    }

    return wrapped
  }
}

extension Optional where Wrapped: Collection {
  /// Check if optional is nil or has an empty collection.
  @inlinable
  public var isNilOrEmpty: Bool {
    guard let collection = self else { return false }
    return collection.isEmpty
  }
}
