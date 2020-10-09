import Foundation

public final class Box<Value> {

  // MARK: Lifecycle

  public init(_ value: Value) {
    self.value = value
  }

  // MARK: Public

  public let value: Value

}

extension Box: Encodable where Value: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(value)
  }
}

extension Box: Decodable where Value: Decodable {
  public convenience init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.init(try container.decode(Value.self))
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

  // MARK: Lifecycle

  public init(_ value: Value) {
    self.value = value
  }

  // MARK: Public

  public var value: Value

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

extension MutableBox: Encodable where Value: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(value)
  }
}

extension MutableBox: Decodable where Value: Decodable {
  public convenience init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.init(try container.decode(Value.self))
  }
}
