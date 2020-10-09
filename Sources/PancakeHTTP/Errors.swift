import Foundation

public enum Errors {
  public static let domain = "PancakeHTTP"

  public enum Code: Int {
    case invalidEndpoint
  }

  public static var invalidEndpoint: Error {
    makeError(code: .invalidEndpoint, userInfo: nil)
  }

  private static func makeError(code: Code, userInfo: [String: Any]?) -> Error {
    NSError(domain: domain, code: code.rawValue, userInfo: userInfo)
  }
}
