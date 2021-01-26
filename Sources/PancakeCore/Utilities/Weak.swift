public final class Weak<Wrapped> {

  // MARK: Lifecycle

  public init(_ value: Wrapped? = nil) {
    self.value = value
  }

  // MARK: Public

  public var value: Wrapped? {
    get { _value as? Wrapped }
    set { _value = newValue as AnyObject }
  }

  // MARK: Private

  private weak var _value: AnyObject?
}
