import Foundation

private let dateFormatter = ISO8601DateFormatter()

extension Logger {
  public struct Log {
    public let date: Date
    public let level: Logger.Level
    public let msg: Any
    public let function: String
    public let file: String
    public let line: Int
    public let context: Any?
    public let system: String

    public var json: [String: Any] {
      var json: [String: Any] = [:]
      json["date"] = date.timeIntervalSince1970
      json["level"] = level.rawValue
      json["msg"] = msg
      json["function"] = function
      json["file"] = file
      json["line"] = line
      json["context"] = context
      json["system"] = system
      return json
    }
  }
}

extension Logger.Log: CustomStringConvertible {
  public var description: String {
    let dateString = dateFormatter.string(from: date)
    let contextString = context.map { "\($0)" } ?? "<nil>"
    let fileName = file.split(separator: "/").last?.split(separator: ".").first ?? ""
    return
      "\(dateString) [\(level.rawValue)][\(system)] \(msg) \(fileName).\(function):\(line) | \(contextString)"
  }
}
