import Foundation

public final class Box<Value> {

    public let value: Value

    public init(_ value: Value) {
        self.value = value
    }
}

extension Box: Equatable where Value: Equatable {
    public static func == (lhs: Box<Value>, rhs: Box<Value>) -> Bool {
        lhs.value == rhs.value
    }
}

extension Box: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        value.hash(into: &hasher)
    }
}

extension Box: Comparable where Value: Comparable {
    public static func < (lhs: Box<Value>, rhs: Box<Value>) -> Bool {
        lhs.value < rhs.value
    }
}

public final class MutableBox<Value> {

    public var value: Value

    public init(_ value: Value) {
        self.value = value
    }
}

extension MutableBox: Equatable where Value: Equatable {
    public static func == (lhs: MutableBox<Value>, rhs: MutableBox<Value>) -> Bool {
        lhs.value == rhs.value
    }
}

extension MutableBox: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        value.hash(into: &hasher)
    }
}

extension MutableBox: Comparable where Value: Comparable {
    public static func < (lhs: MutableBox<Value>, rhs: MutableBox<Value>) -> Bool {
        lhs.value < rhs.value
    }
}
