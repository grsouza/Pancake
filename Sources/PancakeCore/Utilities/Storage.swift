import Foundation

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
    private let lock = Lock.make()
    private var storage: [ObjectIdentifier: Any] = [:]

    /// Storage's singleton
    public static let global = Storage()

    public init() {}

    public subscript<Key>(_ key: Key.Type) -> Key.Value where Key: StorageKey {
        get { get(key) }
        set { set(key, to: newValue) }
    }

    public func get<Key>(_ key: Key.Type) -> Key.Value where Key: StorageKey {
        lock.around {
            guard let value = self.storage[key.id] as? Key.Value else {
                return Key.defaultValue
            }

            return value
        }
    }

    public func set<Key>(_ key: Key.Type, to value: Key.Value?) where Key: StorageKey {
        lock.around {
            self.storage[key.id] = value
        }
    }

    public func contains<Key>(_ key: Key.Type) -> Bool where Key: StorageKey {
        lock.around {
            self.storage.keys.contains(key.id)
        }
    }
}
