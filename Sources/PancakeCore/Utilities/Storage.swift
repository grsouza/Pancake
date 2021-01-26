import Foundation

public protocol StorageKey {
  associatedtype Value

  static var defaultValue: Value { get }
}

extension StorageKey {
  @usableFromInline
  internal static var id: ObjectIdentifier {
    ObjectIdentifier(self)
  }
}

public final class Storage {

  // MARK: Lifecycle

  public init() {}

  // MARK: Public

  /// Storage's singleton
  public static var global = Storage()

  @inlinable
  public subscript<Key>(_ key: Key.Type) -> Key.Value where Key: StorageKey {
    get { get(key) }
    set { set(key, to: newValue) }
  }

  @inlinable
  public func get<Key>(_ key: Key.Type) -> Key.Value where Key: StorageKey {
    storage.read {
      guard let value = $0[key.id] else {
        return Key.defaultValue
      }

      guard let typedValue = value  as? Key.Value else {
        assertionFailure("unexpected typed value: \(value)")
        return Key.defaultValue
      }

      return typedValue
    }
  }

  @inlinable
  public func set<Key>(_ key: Key.Type, to value: Key.Value?) where Key: StorageKey {
    storage.write {
      $0[key.id] = value
    }
  }

  @inlinable
  public func contains<Key>(_ key: Key.Type) -> Bool where Key: StorageKey {
    storage.read {
      $0.keys.contains(key.id)
    }
  }

  // MARK: Internal

  @usableFromInline
  internal var storage = ThreadSafe<[ObjectIdentifier: Any]>(value: [:])

}
