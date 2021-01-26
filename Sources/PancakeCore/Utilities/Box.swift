public final class Box<Wrapped> {

  // MARK: Lifecycle

  public init(_ value: Wrapped) {
    self.value = value
  }

  // MARK: Public

  public let value: Wrapped
}

extension Box: Comparable where Wrapped: Comparable {
  public static func < (lhs: Box<Wrapped>, rhs: Box<Wrapped>) -> Bool {
    lhs.value < rhs.value
  }
}

extension Box: Equatable where Wrapped: Equatable {
  public static func == (lhs: Box<Wrapped>, rhs: Box<Wrapped>) -> Bool {
    lhs.value == rhs.value
  }
}

extension Box: Hashable where Wrapped: Hashable {
  public func hash(into hasher: inout Hasher) {
    value.hash(into: &hasher)
  }
}

extension Box: Encodable where Wrapped: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(value)
  }
}

extension Box: Decodable where Wrapped: Decodable {
  public convenience init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    try self.init(container.decode(Wrapped.self))
  }
}

extension Box: CustomStringConvertible where Wrapped: CustomStringConvertible {
  public var description: String {
    "Box(\(value.description))"
  }
}

extension Box: CustomDebugStringConvertible where Wrapped: CustomDebugStringConvertible {
  public var debugDescription: String {
    "Box(\(value.debugDescription))"
  }
}

public final class MutableBox<Wrapped> {

  // MARK: Lifecycle

  public init(_ value: Wrapped) {
    self.value = value
  }

  // MARK: Public

  public var value: Wrapped
}


extension MutableBox: Comparable where Wrapped: Comparable {
  public static func < (lhs: MutableBox<Wrapped>, rhs: MutableBox<Wrapped>) -> Bool {
    lhs.value < rhs.value
  }
}

extension MutableBox: Equatable where Wrapped: Equatable {
  public static func == (lhs: MutableBox<Wrapped>, rhs: MutableBox<Wrapped>) -> Bool {
    lhs.value == rhs.value
  }
}

extension MutableBox: Hashable where Wrapped: Hashable {
  public func hash(into hasher: inout Hasher) {
    value.hash(into: &hasher)
  }
}

extension MutableBox: Encodable where Wrapped: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(value)
  }
}

extension MutableBox: Decodable where Wrapped: Decodable {
  public convenience init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    try self.init(container.decode(Wrapped.self))
  }
}

extension MutableBox: CustomStringConvertible where Wrapped: CustomStringConvertible {
  public var description: String {
    "MutableBox(\(value.description))"
  }
}

extension MutableBox: CustomDebugStringConvertible where Wrapped: CustomDebugStringConvertible {
  public var debugDescription: String {
    "MutableBox(\(value.debugDescription))"
  }
}
