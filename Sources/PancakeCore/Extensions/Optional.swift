import Foundation

extension Optional {

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
    public var isNilOrEmpty: Bool {
        guard let collection = self else { return false }
        return collection.isEmpty
    }
}
