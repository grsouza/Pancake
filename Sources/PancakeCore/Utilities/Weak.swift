import Foundation

public final class Weak<Value> {

  // MARK: Lifecycle

  public init(_ value: Value? = nil) {
    self.value = value
  }

  // MARK: Public

  public var value: Value? {
    get { _value as? Value }
    set { _value = newValue as AnyObject }
  }

  // MARK: Private

  private weak var _value: AnyObject?

}

extension Weak: Equatable where Value: Equatable {
  public static func == (lhs: Weak<Value>, rhs: Weak<Value>) -> Bool {
    lhs.value == rhs.value
  }
}

extension Weak: Hashable where Value: Hashable {
  public func hash(into hasher: inout Hasher) {
    value.hash(into: &hasher)
  }
}

extension Weak: Comparable where Value: Comparable {
  public static func < (lhs: Weak<Value>, rhs: Weak<Value>) -> Bool {
    guard let lValue = lhs.value, let rValue = rhs.value else {
      return false
    }

    return lValue < rValue
  }
}
