import Foundation

public final class Weak<Value: AnyObject> {
    public weak var value: Value?

    public init(_ value: Value) {
        self.value = value
    }
}

extension Weak: Equatable where Value: Equatable {
    public static func == (lhs: Weak<Value>, rhs: Weak<Value>) -> Bool {
        lhs.value == rhs.value
    }
}

extension Weak: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        value.hash(into: &hasher)
    }
}

extension Weak: Comparable where Value: Comparable {
    public static func < (lhs: Weak<Value>, rhs: Weak<Value>) -> Bool {
        guard let lValue = lhs.value, let rValue = rhs.value else {
            return false
        }

        return lValue < rValue
    }
}
