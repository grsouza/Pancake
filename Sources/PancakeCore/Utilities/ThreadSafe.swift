import Foundation

public final class ThreadSafe<Value> {

  // MARK: Lifecycle

  public init(value: Value) {
    self.value = value
  }

  // MARK: Public

  public func read<Result>(_ block: (Value) throws -> Result) rethrows -> Result {
    try lock.around {
      try block(value)
    }
  }

  public func write<Result>(_ block: (inout Value) throws -> Result) rethrows -> Result {
    try lock.around {
      try block(&value)
    }
  }

  // MARK: Private

  private let lock = Lock.make()
  private var value: Value

}
