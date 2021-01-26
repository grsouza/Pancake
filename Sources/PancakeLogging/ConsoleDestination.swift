import Foundation

public final class ConsoleDestination: Destination {

  // MARK: Lifecycle

  public init(json: Bool = false) {
    let uuid = UUID().uuidString

    queue = DispatchQueue(label: "dev.grds.pancake.logging-\(uuid)")
    self.json = json
    dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
  }

  // MARK: Public

  public func send(
    _ level: Logger.Level,
    msg: String,
    thread: String,
    file: String,
    function: String,
    line: Int,
    context: Any?
  ) {
    let date = Date()
    let message: String

    if json {
      let dict = [
        "level": level.rawValue,
        "message": msg,
        "thread": thread,
        "file": file,
        "function": function,
        "line": line,
        "context": context,
        "datetime": date.timeIntervalSince1970,
      ]

      if let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
        message = String(data: data, encoding: .utf8) ?? ""
      } else {
        message = ""
      }
    } else {
      let dateString = dateFormatter.string(from: date)
      message = "\(dateString) \(levelString(for: level)) \(emoji(for: level)) \(fileName(for: file)).\(function):\(line) - \(msg)"
    }

    queue.async {
      print(message)
    }
  }

  // MARK: Private

  private let json: Bool
  private let queue: DispatchQueue
  private let dateFormatter: DateFormatter

  private func fileName(for file: String) -> String {
    file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
  }

  private func emoji(for level: Logger.Level) -> String {
    switch level {
    case .verbose: return "📝"
    case .debug: return "✅"
    case .info: return "ℹ️"
    case .warning: return "⚠️"
    case .error: return "🚫"
    }
  }

  private func levelString(for level: Logger.Level) -> String {
    switch level {
    case .verbose: return "VERBOSE"
    case .debug: return "DEBUG"
    case .info: return "INFO"
    case .warning: return "WARNING"
    case .error: return "ERROR"
    }
  }
}
