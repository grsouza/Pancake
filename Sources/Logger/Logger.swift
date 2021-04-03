import Foundation

internal struct World {
  var date: () -> Date
}

#if DEBUG
  internal var Current = World(date: Date.init)
#else
  internal let Current = World(date: Date.init)
#endif

public struct Logger {

  public let system: String
  public let destinations: [Destination]

  public enum Level: String, Encodable {
    case verbose = "VERBOSE"
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
  }

  public init(
    system: String,
    destinations: [Destination]
  ) {
    self.system = system
    self.destinations = destinations
  }

}

extension Logger {
  public func log(
    level: Level,
    msg: @autoclosure () -> Any,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    context: Any? = nil
  ) {
    let message = Log(
      date: Current.date(),
      level: level,
      msg: msg(),
      function: function,
      file: file,
      line: line,
      context: context,
      system: system
    )

    destinations.forEach {
      $0.log(message)
    }
  }

  public func verbose(
    _ msg: @autoclosure () -> Any,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    context: Any? = nil
  ) {
    log(level: .verbose, msg: msg(), function: function, file: file, line: line, context: context)
  }

  public func debug(
    _ msg: @autoclosure () -> Any,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    context: Any? = nil
  ) {
    log(level: .debug, msg: msg(), function: function, file: file, line: line, context: context)
  }

  public func info(
    _ msg: @autoclosure () -> Any,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    context: Any? = nil
  ) {
    log(level: .info, msg: msg(), function: function, file: file, line: line, context: context)
  }

  public func warning(
    _ msg: @autoclosure () -> Any,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    context: Any? = nil
  ) {
    log(level: .warning, msg: msg(), function: function, file: file, line: line, context: context)
  }

  public func error(
    _ msg: @autoclosure () -> Any,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    context: Any? = nil
  ) {
    log(level: .error, msg: msg(), function: function, file: file, line: line, context: context)
  }
}
