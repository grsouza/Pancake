import Foundation

public final class RWLock {

  // MARK: Lifecycle

  public init() {
    lock = UnsafeMutablePointer.allocate(capacity: 1)
    let status = pthread_rwlock_init(lock, nil)
    assert(status == 0)
  }

  deinit {
    let status = pthread_rwlock_destroy(lock)
    assert(status == 0)
    lock.deinitialize(count: 1)
    lock.deallocate()
  }

  // MARK: Public

  public func read<Result>(_ block: () throws -> Result) rethrows -> Result {
    pthread_rwlock_rdlock(lock)
    defer { pthread_rwlock_unlock(lock) }
    return try block()
  }

  public func write<Result>(_ block: () throws -> Result) rethrows -> Result {
    pthread_rwlock_wrlock(lock)
    defer { pthread_rwlock_unlock(lock) }
    return try block()
  }

  // MARK: Private

  private var lock: UnsafeMutablePointer<pthread_rwlock_t>

}
