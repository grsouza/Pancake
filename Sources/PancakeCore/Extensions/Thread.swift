import Foundation

extension Thread {
  /// Returns the name of the thread or 'main-thread', if it's the application's main thread
  @inlinable
  public class var currentName: String {
    guard !isMainThread else {
      return "main-thread"
    }

    if let threadName = current.name, !threadName.isEmpty {
      return threadName
    }

    return String(format: "%p", current)
  }
}
