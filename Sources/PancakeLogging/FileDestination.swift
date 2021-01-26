import Foundation

public final class FileDestination: Destination {

  // MARK: Lifecycle

  public init() {
    let uuid = UUID().uuidString

    queue = DispatchQueue(label: "dev.grds.pancake.logging-\(uuid)")
    dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

    let fileManager = FileManager.default
    logFileURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("panckagelogging.log")
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
    let dateString = dateFormatter.string(from: date)
    let message = "\(dateString) \(levelString(for: level)) \(emoji(for: level)) \(fileName(for: file)).\(function):\(line) - \(msg)"

    queue.async {
      do {
        let handle = try FileHandle(forWritingTo: self.logFileURL)
        handle.seekToEndOfFile()
        handle.write("\(message)\n".data(using: .utf8) ?? Data())
        handle.synchronizeFile()
        handle.closeFile()
      } catch {
        print("Failed writing file with error: \(String(describing: error))")
      }
    }
  }

  // MARK: Private

  private let queue: DispatchQueue
  private let dateFormatter: DateFormatter

  private let logFileURL: URL

}
