import SwiftUI

@available(iOS 13.0, *)
@available(macOS 10.15, *)
struct LoggerEnvironmentKey: EnvironmentKey {
  static var defaultValue = Logger(system: "dev.grds.logger-default", destinations: [.console])
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension EnvironmentValues {
  public var logger: Logger {
    get { self[LoggerEnvironmentKey.self] }
    set { self[LoggerEnvironmentKey.self] = newValue }
  }
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension View {
  public func logging(using logger: Logger) -> some View {
    environment(\.logger, logger)
  }
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
struct LogViewModifier: ViewModifier {
  @Environment(\.logger) var logger

  let level: Logger.Level
  let msg: Any
  let function: String
  let file: String
  let line: Int
  let context: Any?

  func body(content: Content) -> some View {
    logger.log(level: level, msg: msg, function: function, file: file, line: line, context: context)
    return content
  }
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension View {
  public func debug(
    _ msg: @autoclosure () -> Any,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    context: Any? = nil
  ) -> some View {
    modifier(
      LogViewModifier(
        level: .debug,
        msg: msg(),
        function: function,
        file: file,
        line: line,
        context: context
      ))
  }

  public func verbose(
    _ msg: @autoclosure () -> Any,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    context: Any? = nil
  ) -> some View {
    modifier(
      LogViewModifier(
        level: .verbose,
        msg: msg(),
        function: function,
        file: file,
        line: line,
        context: context
      ))
  }

  public func info(
    _ msg: @autoclosure () -> Any,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    context: Any? = nil
  ) -> some View {
    modifier(
      LogViewModifier(
        level: .info,
        msg: msg(),
        function: function,
        file: file,
        line: line,
        context: context
      ))
  }

  public func warning(
    _ msg: @autoclosure () -> Any,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    context: Any? = nil
  ) -> some View {
    modifier(
      LogViewModifier(
        level: .warning,
        msg: msg(),
        function: function,
        file: file,
        line: line,
        context: context
      ))
  }

  public func error(
    _ msg: @autoclosure () -> Any,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    context: Any? = nil
  ) -> some View {
    modifier(
      LogViewModifier(
        level: .error,
        msg: msg(),
        function: function,
        file: file,
        line: line,
        context: context
      ))
  }
}
