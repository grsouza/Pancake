public final class Weak<Wrapped> {

  private weak var value: AnyObject?

  public var wrappedValue: Wrapped? {
    get { value as? Wrapped }
    set { value = newValue as AnyObject }
  }

  public init(_ value: Wrapped? = nil) {
    self.wrappedValue = value
  }
}
