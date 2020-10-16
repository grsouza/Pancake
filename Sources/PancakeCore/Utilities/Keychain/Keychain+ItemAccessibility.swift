import Foundation

extension Keychain {
  public enum ItemAccessibility {
    case afterFirstUnlock
    case afterFirstUnlockThisDeviceOnly
    case always
    case whenPasscodeSetThisDeviceOnly
    case alwaysThisDeviceOnly
    case whenUnlocked
    case whenUnlockedThisDeviceOnly
  }
}

private let keychainItemAccessbilityLookup: [Keychain.ItemAccessibility: CFString] = [
  .afterFirstUnlock: kSecAttrAccessibleAfterFirstUnlock,
  .afterFirstUnlockThisDeviceOnly: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
  .always: kSecAttrAccessibleAlways,
  .whenPasscodeSetThisDeviceOnly: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
  .alwaysThisDeviceOnly: kSecAttrAccessibleAlwaysThisDeviceOnly,
  .whenUnlocked: kSecAttrAccessibleWhenUnlocked,
  .whenUnlockedThisDeviceOnly: kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
]

extension Keychain.ItemAccessibility {
  static func accessibilityForAttributeValue(_ attrValue: CFString) -> Keychain.ItemAccessibility? {
    keychainItemAccessbilityLookup.first { key, value in
      value == attrValue
    }?.key
  }

  var attrValue: CFString {
    keychainItemAccessbilityLookup[self]!
  }
}
