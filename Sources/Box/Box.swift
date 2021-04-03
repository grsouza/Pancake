public final class Box<Wrapped> {

  public internal(set) var wrappedValue: Wrapped

  public init(_ value: Wrapped) {
    self.wrappedValue = value
  }
}

extension Box: Comparable where Wrapped: Comparable {
  public static func < (lhs: Box<Wrapped>, rhs: Box<Wrapped>) -> Bool {
    lhs.wrappedValue < rhs.wrappedValue
  }
}

extension Box: Equatable where Wrapped: Equatable {
  public static func == (lhs: Box<Wrapped>, rhs: Box<Wrapped>) -> Bool {
    lhs.wrappedValue == rhs.wrappedValue
  }
}

extension Box: Hashable where Wrapped: Hashable {
  public func hash(into hasher: inout Hasher) {
    wrappedValue.hash(into: &hasher)
  }
}

extension Box: Encodable where Wrapped: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(wrappedValue)
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
    "Box(\(wrappedValue.description))"
  }
}

extension Box: CustomDebugStringConvertible where Wrapped: CustomDebugStringConvertible {
  public var debugDescription: String {
    "Box(\(wrappedValue.debugDescription))"
  }
}
