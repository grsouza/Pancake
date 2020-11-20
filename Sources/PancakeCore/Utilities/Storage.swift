import Foundation
import ThreadSafe

public protocol StorageKey {
  associatedtype Value

  static var defaultValue: Value { get }
}

extension StorageKey {
  fileprivate static var id: ObjectIdentifier {
    ObjectIdentifier(self)
  }
}

public final class Storage {

  // MARK: Lifecycle

  public init() {}

  // MARK: Public

  /// Storage's singleton
  public static let global = Storage()

  public subscript<Key>(_ key: Key.Type) -> Key.Value where Key: StorageKey {
    get { get(key) }
    set { set(key, to: newValue) }
  }

  public func get<Key>(_ key: Key.Type) -> Key.Value where Key: StorageKey {
    storage.read {
      guard let value = $0[key.id] as? Key.Value else {
        return Key.defaultValue
      }

      return value
    }
  }

  public func set<Key>(_ key: Key.Type, to value: Key.Value?) where Key: StorageKey {
    storage.write {
      $0[key.id] = value
    }
  }

  public func contains<Key>(_ key: Key.Type) -> Bool where Key: StorageKey {
    storage.read {
      $0.keys.contains(key.id)
    }
  }

  // MARK: Private

  private var storage = ThreadSafe<[ObjectIdentifier: Any]>(value: [:])

}
