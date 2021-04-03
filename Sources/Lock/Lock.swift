import Foundation

public protocol LockProtocol {
    func lock()
    func unlock()
    func `try`() -> Bool
}

extension LockProtocol {
    public func around<Result>(
        _ criticalSection: () throws -> Result
    ) rethrows -> Result {
      lock()
      defer { unlock() }
      return try criticalSection()
    }
}

public enum Lock {
    
    public static func make() -> LockProtocol {
        if #available(*, macOS 10.12) {
          return UnfairLock()
        }

        return PthreadLock()
    }
}
