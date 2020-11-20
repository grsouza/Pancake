import Foundation
import PancakeCore

public final class Keychain {

  // MARK: Lifecycle

  convenience init() {
    self.init(serviceName: Keychain.defaultKeychainServiceName)
  }

  public init(serviceName: String, accessGroup: String? = nil) {
    self.serviceName = serviceName
    self.accessGroup = accessGroup
  }

  // MARK: Public

  public struct Key: Hashable, RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }

  public static let standard = Keychain()

  private(set) public var serviceName: String
  private(set) public var accessGroup: String?

  public func integer(
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Int? {
    guard let numberValue = object(
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    ) as? NSNumber else {
      return nil
    }

    return numberValue.intValue
  }

  public func float(
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Float? {
    guard let numberValue = object(
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    ) as? NSNumber else {
      return nil
    }

    return numberValue.floatValue
  }

  public func double(
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Double? {
    guard let numberValue = object(
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    ) as? NSNumber else {
      return nil
    }

    return numberValue.doubleValue
  }

  public func bool(
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Bool? {
    guard let numberValue = object(
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    ) as? NSNumber else {
      return nil
    }

    return numberValue.boolValue
  }

  public func string(
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> String? {
    guard let data = data(
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    ) else {
      return nil
    }

    return data.string(encoding: .utf8)
  }

  public func object(
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> NSCoding? {
    guard let keychainData = data(
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    ) else {
      return nil
    }

    return NSKeyedUnarchiver.unarchiveObject(with: keychainData) as? NSCoding
  }

  public func data(
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Data? {
    let queryDictionary = makeQueryDictionary(
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    ).with {
      $0[kSecMatchLimit] = kSecMatchLimitOne
      $0[kSecReturnData] = kCFBooleanTrue
    }

    var result: AnyObject?
    let status = SecItemCopyMatching(queryDictionary as CFDictionary, &result)

    return status == noErr ? result as? Data : nil
  }

  @discardableResult
  public func set(
    _ value: Int,
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Bool {
    set(
      NSNumber(value: value),
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    )
  }

  @discardableResult
  public func set(
    _ value: Float,
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Bool {
    set(
      NSNumber(value: value),
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    )
  }

  @discardableResult
  public func set(
    _ value: Double,
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Bool {
    set(
      NSNumber(value: value),
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    )
  }

  @discardableResult
  public func set(
    _ value: Bool,
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Bool {
    set(
      NSNumber(value: value),
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    )
  }

  @discardableResult
  public func set(
    _ value: String,
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Bool {
    value.data(using: .utf8).map {
      set(
        $0,
        forKey: key,
        withAccessibility: accessibility,
        isSynchronizable: isSynchronizable
      )
    } ?? false
  }

  @discardableResult
  public func set(
    _ value: NSCoding,
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Bool {
    let data = NSKeyedArchiver.archivedData(withRootObject: value)
    return set(
      data,
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    )
  }

  @discardableResult
  public func set(
    _ data: Data,
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Bool {
    let queryDictionary = makeQueryDictionary(
      forKey: key,
      withAccessibility: accessibility ?? ItemAccessibility.whenUnlocked, // Use default protection, protect the keychain entry so it's only valid when the device is unlocked
      isSynchronizable: isSynchronizable
    ).with {
      $0[kSecValueData] = data
    }

    let status = SecItemAdd(queryDictionary as CFDictionary, nil)

    if status == errSecSuccess {
      return true
    }

    if status == errSecDuplicateItem {
      return update(
        data,
        forKey: key,
        withAccessibility: accessibility,
        isSynchronizable: isSynchronizable
      )
    }

    return false
  }

  @discardableResult
  public func removeObject(
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility? = nil,
    isSynchronizable: Bool = false
  ) -> Bool {
    let queryDictionary = makeQueryDictionary(
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    )

    let status = SecItemDelete(queryDictionary as CFDictionary)

    return status == errSecSuccess
  }

  public func update(
    _ data: Data,
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility?,
    isSynchronizable: Bool
  ) -> Bool {
    let queryDictionary = makeQueryDictionary(
      forKey: key,
      withAccessibility: accessibility,
      isSynchronizable: isSynchronizable
    )

    let updateDictionary = [kSecValueData: data]

    let status = SecItemUpdate(queryDictionary as CFDictionary, updateDictionary as CFDictionary)

    return status == errSecSuccess
  }

  // MARK: Private

  private static let defaultKeychainServiceName: String = {
    Bundle.main.bundleIdentifier ?? "dev.grds.pancakekeychain"
  }()

  private func makeQueryDictionary(
    forKey key: Key,
    withAccessibility accessibility: ItemAccessibility?,
    isSynchronizable: Bool
  ) -> [CFString: Any] {
    var queryDictionary: [CFString: Any] = [kSecClass: kSecClassGenericPassword]
    queryDictionary[kSecAttrService] = serviceName

    if let accessibility = accessibility {
      queryDictionary[kSecAttrAccessible] = accessibility.attrValue
    }

    if let accessGroup = accessGroup {
      queryDictionary[kSecAttrAccessGroup] = accessGroup
    }

    let identifier = key.rawValue.data(using: .utf8)
    queryDictionary[kSecAttrGeneric] = identifier
    queryDictionary[kSecAttrAccount] = identifier

    queryDictionary[kSecAttrSynchronizable] = isSynchronizable ? kCFBooleanTrue : kCFBooleanFalse

    return queryDictionary
  }
}
