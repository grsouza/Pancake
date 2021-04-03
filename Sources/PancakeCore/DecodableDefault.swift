import Foundation

public protocol DecodableDefaultSource {
  associatedtype Value: Decodable
  static var defaultValue: Value { get }
}

public enum DecodableDefault {}

extension DecodableDefault {

  @propertyWrapper
  public struct Wrapper<Source: DecodableDefaultSource> {
    public typealias Value = Source.Value
    public var wrappedValue: Value

    public init() {
      wrappedValue = Source.defaultValue
    }

    public init(wrappedValue: Value) {
      self.wrappedValue = wrappedValue
    }
  }
}

extension DecodableDefault.Wrapper: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    wrappedValue = try container.decode(Value.self)
  }
}

extension KeyedDecodingContainer {
  func decode<T>(_ type: DecodableDefault.Wrapper<T>.Type, forKey key: Key) throws
    -> DecodableDefault.Wrapper<T>
  {
    try decodeIfPresent(type, forKey: key) ?? .init()
  }
}

extension DecodableDefault {
  public typealias List = Decodable & ExpressibleByArrayLiteral
  public typealias Map = Decodable & ExpressibleByDictionaryLiteral

  public enum Sources {

    public enum True: DecodableDefaultSource {
      public static var defaultValue: Bool { true }
    }

    public enum False: DecodableDefaultSource {
      public static var defaultValue: Bool { false }
    }

    public enum EmptyString: DecodableDefaultSource {
      public static var defaultValue: String { "" }
    }

    public enum EmptyList<T: List>: DecodableDefaultSource {
      public static var defaultValue: T { [] }
    }

    public enum EmptyMap<T: Map>: DecodableDefaultSource {
      public static var defaultValue: T { [:] }
    }
  }
}

extension DecodableDefault {
  public typealias True = Wrapper<Sources.True>
  public typealias False = Wrapper<Sources.False>
  public typealias EmptyString = Wrapper<Sources.EmptyString>
  public typealias EmptyList<T: List> = Wrapper<Sources.EmptyList<T>>
  public typealias EmptyMap<T: Map> = Wrapper<Sources.EmptyMap<T>>
}

extension DecodableDefault.Wrapper: Equatable where Value: Equatable {}
extension DecodableDefault.Wrapper: Hashable where Value: Hashable {}
extension DecodableDefault.Wrapper: Comparable where Value: Comparable {
  public static func < (
    lhs: DecodableDefault.Wrapper<Source>,
    rhs: DecodableDefault.Wrapper<Source>
  ) -> Bool {
    lhs.wrappedValue < rhs.wrappedValue
  }
}

extension DecodableDefault.Wrapper: Encodable where Value: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(wrappedValue)
  }
}
