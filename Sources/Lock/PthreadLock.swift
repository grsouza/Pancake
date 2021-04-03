import Foundation

final class PthreadLock: LockProtocol {

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

  }

  deinit {
    let status = pthread_mutex_destroy(_lock)
    assert(status == 0, "Unexpected pthread mutex error code: \(status)")

    _lock.deinitialize(count: 1)
    _lock.deallocate()
  }

  // MARK: Internal

  func lock() {
    let status = pthread_mutex_lock(_lock)
    assert(status == 0, "Unexpected pthread mutex error code: \(status)")
  }

  func unlock() {
    let status = pthread_mutex_unlock(_lock)
    assert(status == 0, "Unexpected pthread mutex error code: \(status)")
  }

  func `try`() -> Bool {
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
