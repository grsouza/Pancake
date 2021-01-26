import Foundation

public final class ThreadSafe<Wrapped> {

  // MARK: Lifecycle

  public init(value: Wrapped) {
    self.value = value
  }

  // MARK: Public

  public func read<Result>(_ block: (Wrapped) throws -> Result) rethrows -> Result {
    try lock.around {
      try block(value)
    }
  }

  public func write<Result>(_ block: (inout Wrapped) throws -> Result) rethrows -> Result {
    try lock.around {
      try block(&value)
    }
  }

  // MARK: Private

  private let lock = Lock.make()
  private var value: Wrapped
}
