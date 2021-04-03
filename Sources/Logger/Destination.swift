import Foundation

extension Logger {
  public struct Destination {
    public var log: (Logger.Log) -> Void

    public init(log: @escaping (Logger.Log) -> Void) {
      self.log = log
    }
  }
}

extension Logger.Destination {

  public static let console = Self(
    log: { msg in
      #if DEBUG
        print(msg.description)
      #endif
    }
  )

  public static func file(named name: String = "default.log") -> Logger.Destination {
    let queue = DispatchQueue(label: "dev.grds.pancakge.logger.filedestination")

    return Logger.Destination { msg in
      queue.sync {
        do {
          let fileURL = try FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true
          )
          .appendingPathComponent(name)

          let handle = try FileHandle(forWritingTo: fileURL)
          handle.seekToEndOfFile()
          handle.write(Data(msg.description.utf8))
          handle.closeFile()
        } catch {
          // no-op
        }
      }
    }
  }
}
