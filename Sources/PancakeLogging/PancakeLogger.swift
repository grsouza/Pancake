import Foundation
import PancakeCore

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

public enum Logger {

  // MARK: Public

  public enum Level: Int {
    case verbose = 0
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4
  }

  public static func addDestinations(_ destinations: [Destination]) {
    self.destinations.append(contentsOf: destinations)
  }

  public static func addDestinations(_ destinations: Destination...) {
    addDestinations(destinations)
  }

  public static func verbose(
    message: @autoclosure () -> Any,
    file: String = #file,
    function: String = #function,
    line: Int = #line,
    context: Any? = nil
  ) {
    custom(
      level: .verbose,
      message: message(),
      file: file,
      function: function,
      line: line,
      context: context
    )
  }

  public static func debug(
    message: @autoclosure () -> Any,
    file: String = #file,
    function: String = #function,
    line: Int = #line,
    context: Any? = nil
  ) {
    custom(
      level: .debug,
      message: message(),
      file: file,
      function: function,
      line: line,
      context: context
    )
  }

  public static func info(
    message: @autoclosure () -> Any,
    file: String = #file,
    function: String = #function,
    line: Int = #line,
    context: Any? = nil
  ) {
    custom(
      level: .info,
      message: message(),
      file: file,
      function: function,
      line: line,
      context: context
    )
  }

  public static func warning(
    message: @autoclosure () -> Any,
    file: String = #file,
    function: String = #function,
    line: Int = #line,
    context: Any? = nil
  ) {
    custom(
      level: .warning,
      message: message(),
      file: file,
      function: function,
      line: line,
      context: context
    )
  }

  public static func error(
    message: @autoclosure () -> Any,
    file: String = #file,
    function: String = #function,
    line: Int = #line,
    context: Any? = nil
  ) {
    custom(
      level: .error,
      message: message(),
      file: file,
      function: function,
      line: line,
      context: context
    )
  }

  public static func custom(
    level: Level,
    message: @autoclosure () -> Any,
    file: String = #file,
    function: String = #function,
    line: Int = #line,
    context: Any? = nil
  ) {
    let resolvedMessage = "\(message())"
    let thread = Thread.currentName
    destinations.forEach {
      $0.send(
        level,
        msg: resolvedMessage,
        thread: thread,
        file: file,
        function: function,
        line: line,
        context: context
      )
    }
  }

  // MARK: Private

  private static var destinations: [Destination] = []

}
