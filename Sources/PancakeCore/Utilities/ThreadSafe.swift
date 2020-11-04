import Foundation

/// Wraps value in a thread safe environemnt.
///
/// Read and write are made throught methods that are synchronized.
/// Reads are concurrent and writes are exclusive.
public final class ThreadSafe<Value> {

  // MARK: Lifecycle

  public init(value: Value) {
    self.value = value
  }

  // MARK: Public

  public func read<Result>(_ block: (Value) throws -> Result) rethrows -> Result {
    try queue.sync {
      try block(value)
    }
  }

  public func write<Result>(_ block: (inout Value) throws -> Result) rethrows -> Result {
    try queue.sync(flags: .barrier) {
      try block(&value)
    }
  }

  // MARK: Private

  private let queue = DispatchQueue(
    label: "dev.grds.pancakecore.threadsafe",
    qos: .utility,
    attributes: .concurrent
  )
  private var value: Value

}
