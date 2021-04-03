import Foundation
import Lock

public final class ThreadSafe<Wrapped> {

  private let lock = RWLock()
  private var value: Wrapped

  public init(value: Wrapped) {
    self.value = value
  }

  public func read<Result>(_ block: (Wrapped) throws -> Result) rethrows -> Result {
    try lock.read {
      try block(value)
    }
  }

  public func write<Result>(_ block: (inout Wrapped) throws -> Result) rethrows -> Result {
    try lock.write {
      try block(&value)
    }
  }
}
