import Foundation

@propertyWrapper
public struct KeychainStored<Value> {

  // MARK: Lifecycle

  internal init(
    getter: @escaping () -> Value?,
    setter: @escaping (Value) -> Void,
    remove: @escaping () -> Bool
  ) {
    self.getter = getter
    self.setter = setter
    self.remove = remove
  }

  // MARK: Public

  public var wrappedValue: Value? {
    get { getter() }
    set {
      if let newValue = newValue {
        setter(newValue)
      } else {
        removeObject()
      }
    }
  }

  public var projectedValue: KeychainStored<Value> {
    self
  }

  @discardableResult
  public func removeObject() -> Bool {
    remove()
  }

  // MARK: Private

  private let getter: () -> Value?
  private let setter: (Value) -> Void
  private let remove: () -> Bool

}

extension KeychainStored where Value == Int {
  public init(
    key: String,
    accessibility: Keychain.ItemAccessibility? = nil,
    isSynchronizable: Bool = false,
    in keychain: Keychain = Keychain.standard
  ) {
    self.init(
      getter: {
        keychain.integer(
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
      },
      setter: {
        keychain.set(
          $0,
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
      },
      remove: { keychain.removeObject(
        forKey: key,
        withAccessibility: accessibility,
        isSynchronizable: isSynchronizable
      ) }
    )
  }
}

extension KeychainStored where Value == Float {
  public init(
    key: String,
    accessibility: Keychain.ItemAccessibility? = nil,
    isSynchronizable: Bool = false,
    in keychain: Keychain = Keychain.standard
  ) {
    self.init(
      getter: {
        keychain.float(
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
      },
      setter: {
        keychain.set(
          $0,
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
      },
      remove: { keychain.removeObject(
        forKey: key,
        withAccessibility: accessibility,
        isSynchronizable: isSynchronizable
      ) }
    )
  }
}

extension KeychainStored where Value == Double {
  public init(
    key: String,
    accessibility: Keychain.ItemAccessibility? = nil,
    isSynchronizable: Bool = false,
    in keychain: Keychain = Keychain.standard
  ) {
    self.init(
      getter: {
        keychain.double(
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
      },
      setter: {
        keychain.set(
          $0,
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
      },
      remove: { keychain.removeObject(
        forKey: key,
        withAccessibility: accessibility,
        isSynchronizable: isSynchronizable
      ) }
    )
  }
}

extension KeychainStored where Value == String {
  public init(
    key: String,
    accessibility: Keychain.ItemAccessibility? = nil,
    isSynchronizable: Bool = false,
    in keychain: Keychain = Keychain.standard
  ) {
    self.init(
      getter: {
        keychain.string(
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
      },
      setter: {
        keychain.set(
          $0,
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
      },
      remove: { keychain.removeObject(
        forKey: key,
        withAccessibility: accessibility,
        isSynchronizable: isSynchronizable
      ) }
    )
  }
}

extension KeychainStored where Value == Data {
  public init(
    key: String,
    accessibility: Keychain.ItemAccessibility? = nil,
    isSynchronizable: Bool = false,
    in keychain: Keychain = Keychain.standard
  ) {
    self.init(
      getter: {
        keychain.data(
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
      },
      setter: {
        keychain.set(
          $0,
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
      },
      remove: { keychain.removeObject(
        forKey: key,
        withAccessibility: accessibility,
        isSynchronizable: isSynchronizable
      ) }
    )
  }
}

extension KeychainStored where Value: NSCoding {
  public init(
    key: String,
    accessibility: Keychain.ItemAccessibility? = nil,
    isSynchronizable: Bool = false,
    in keychain: Keychain = Keychain.standard
  ) {
    self.init(
      getter: {
        keychain.object(
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        ) as? Value
      },
      setter: {
        keychain.set(
          $0,
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
      },
      remove: { keychain.removeObject(
        forKey: key,
        withAccessibility: accessibility,
        isSynchronizable: isSynchronizable
      ) }
    )
  }
}

extension KeychainStored where Value: Codable {
  public init(
    key: String,
    accessibility: Keychain.ItemAccessibility? = nil,
    isSynchronizable: Bool = false,
    in keychain: Keychain = Keychain.standard,
    decoder: JSONDecoder = JSONDecoder(),
    encoder: JSONEncoder = JSONEncoder(),
  ) {
    self.init(
      getter: {
        let data = keychain.data(
          forKey: key,
          withAccessibility: accessibility,
          isSynchronizable: isSynchronizable
        )
        return data.flatMap { try? decoder.decode(Value.self, from: $0) }
      },
      setter: { value in
        if let data = try? encoder.encode(value) {
          keychain.set(
            data,
            forKey: key,
            withAccessibility: accessibility,
            isSynchronizable: isSynchronizable
          )
        } else {
          keychain.removeObject(
            forKey: key,
            withAccessibility: accessibility,
            isSynchronizable: isSynchronizable
          )
        }
      },
      remove: { keychain.removeObject(
        forKey: key,
        withAccessibility: accessibility,
        isSynchronizable: isSynchronizable
      ) }
    )
  }
}
