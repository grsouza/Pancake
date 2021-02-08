import Foundation

public protocol Destination {
  func send(
    _ level: Logger.Level,
    msg: String,
    thread: String,
    file: String,
    function: String,
    line: Int,
    context: Any?
  )
}
extension Destination {
  /// Returns only the file name without the extension.
  func fileName(for file: String) -> String {
    file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
  }

  func emoji(for level: Logger.Level) -> String {
    switch level {
    case .verbose: return "📝"
    case .debug: return "✅"
    case .info: return "ℹ️"
    case .warning: return "⚠️"
    case .error: return "🚫"
    }
  }

  func levelString(for level: Logger.Level) -> String {
    switch level {
    case .verbose: return "VERBOSE"
    case .debug: return "DEBUG"
    case .info: return "INFO"
    case .warning: return "WARNING"
    case .error: return "ERROR"
    }
  }
}
