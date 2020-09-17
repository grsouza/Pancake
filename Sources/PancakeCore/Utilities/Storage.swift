import Foundation

public protocol StorageKey {
    associatedtype Value

    static var defaultValue: Value { get }
}

public final class Storage {

    private let lock = Lock.make()
    private var storage: [ObjectIdentifier: Any] = [:]

    public init() {}

    public subscript<Key>(_ key: Key.Type) -> Key.Value where Key: StorageKey {
        get { get(key) }
        set { set(key, to: newValue) }
    }

    public func get<Key>(_ key: Key.Type) -> Key.Value where Key: StorageKey {
        lock.around {
            guard let value = self.storage[ObjectIdentifier(Key.self)] as? Key.Value else {
                return Key.defaultValue
            }

            return value
        }
    }

    public func set<Key>(_ key: Key.Type, to value: Key.Value?) where Key: StorageKey {
        lock.around {
            let key = ObjectIdentifier(Key.self)
            self.storage[key] = value
        }
    }

    public func contains<Key>(_ key: Key.Type) -> Bool {
        lock.around {
            self.storage.keys.contains(ObjectIdentifier(Key.self))
        }
    }
}
