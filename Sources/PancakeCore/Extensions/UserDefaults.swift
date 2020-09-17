import Foundation

extension UserDefaults {

    public subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    public func float(forKey key: String) -> Float? {
        return object(forKey: key) as? Float
    }

    public func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }

    public func object<T: Codable>(
        _ type: T.Type,
        with key: String,
        usingDecoder decoder: JSONDecoder = JSONDecoder()
    ) throws -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        return try decoder.decode(type.self, from: data)
    }

    public func set<T: Codable>(
        object: T,
        forKey key: String,
        usingEncoder encoder: JSONEncoder = JSONEncoder()
    ) throws {
        let data = try encoder.encode(object)
        set(data, forKey: key)
    }
}
