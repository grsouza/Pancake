import Foundation

extension UserDefaults {
  @inlinable
  public subscript(key: String) -> Any? {
    get { object(forKey: key) }
    set { set(newValue, forKey: key) }
  }

  @inlinable
  public func float(forKey key: String) -> Float? {
    object(forKey: key) as? Float
  }

  @inlinable
  public func date(forKey key: String) -> Date? {
    object(forKey: key) as? Date
  }

  @inlinable
  public func object<T: Codable>(
    _ type: T.Type,
    for key: String,
    usingDecoder decoder: JSONDecoder = JSONDecoder()
  ) throws -> T? {
    guard let data = value(forKey: key) as? Data else { return nil }
    return try decoder.decode(type.self, from: data)
  }

  @inlinable
  public func set<T: Codable>(
    object: T,
    forKey key: String,
    usingEncoder encoder: JSONEncoder = JSONEncoder()
  ) throws {
    let data = try encoder.encode(object)
    set(data, forKey: key)
  }
}
