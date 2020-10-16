import Foundation

/// `Lock` exposes `os_unfair_lock` on supported platforms, with pthread mutex as the fallback (or for recursive locks).
public class Lock {

  // MARK: Lifecycle

  private init() {}

  // MARK: Public

  /// Return an instance of a `Lock`, according to API availability (`os_unfair_lock_t` or `pthread_mutex_t` based).
  ///
  /// - returns: a `Lock` instance
  public static func make() -> Lock {
    if #available(*, iOS 10.0) {
      return UnfairLock()
    }

    return PthreadLock()
  }

  /// Locks the lock
  public func lock() { fatalError("Missing Implementation") }

  /// Unlocks the lock
  public func unlock() { fatalError("Missing Implementation") }

  /// Locks the lock if it is not already locked.
  ///
  /// - Returns: Returns `true` if the lock was succesfully locked and `false` if the lock was already locked.
  public func `try`() -> Bool { fatalError("Missing Implementation") }

  public final func around<Result>(_ criticalSection: () throws -> Result) rethrows -> Result {
    lock()
    defer { unlock() }
    return try criticalSection()
  }

  // MARK: Internal

  final class UnfairLock: Lock {

    // MARK: Lifecycle

    override init() {
      _lock = .allocate(capacity: 1)
      _lock.initialize(to: os_unfair_lock())
      super.init()
    }

    deinit {
      _lock.deinitialize(count: 1)
      _lock.deallocate()
    }

    // MARK: Internal

    override func lock() {
      os_unfair_lock_lock(_lock)
    }

    override func unlock() {
      os_unfair_lock_unlock(_lock)
    }

    override func `try`() -> Bool {
      os_unfair_lock_trylock(_lock)
    }

    // MARK: Private

    private let _lock: os_unfair_lock_t

  }

  final class PthreadLock: Lock {

    // MARK: Lifecycle

    init(recursive: Bool = false) {
      _lock = .allocate(capacity: 1)
      _lock.initialize(to: pthread_mutex_t())

      let attr = UnsafeMutablePointer<pthread_mutexattr_t>.allocate(capacity: 1)
      attr.initialize(to: pthread_mutexattr_t())
      pthread_mutexattr_init(attr)

      defer {
        pthread_mutexattr_destroy(attr)
        attr.deinitialize(count: 1)
        attr.deallocate()
      }

      pthread_mutexattr_settype(
        attr,
        Int32(recursive ? PTHREAD_MUTEX_RECURSIVE : PTHREAD_MUTEX_ERRORCHECK)
      )

      let status = pthread_mutex_init(_lock, attr)
      assert(status == 0, "Unexpected pthread mutex error code: \(status)")

      super.init()
    }

    deinit {
      let status = pthread_mutex_destroy(_lock)
      assert(status == 0, "Unexpected pthread mutex error code: \(status)")

      _lock.deinitialize(count: 1)
      _lock.deallocate()
    }

    // MARK: Internal

    override func lock() {
      let status = pthread_mutex_lock(_lock)
      assert(status == 0, "Unexpected pthread mutex error code: \(status)")
    }

    override func unlock() {
      let status = pthread_mutex_unlock(_lock)
      assert(status == 0, "Unexpected pthread mutex error code: \(status)")
    }

    override func `try`() -> Bool {
      let status = pthread_mutex_trylock(_lock)
      switch status {
      case 0:
        return true
      case EBUSY, EAGAIN:
        return false
      default:
        assertionFailure("Unexpected pthread mutex error code: \(status)")
        return false
      }
    }

    // MARK: Private

    private let _lock: UnsafeMutablePointer<pthread_mutex_t>

  }

}
