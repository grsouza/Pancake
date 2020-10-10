import Foundation

public enum HTTP {
  public enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
  }
}

public struct URLHost: RawRepresentable {
  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }
}

extension URLHost {
  static var staging: Self {
    URLHost(rawValue: "staging.api.myapp.com")
  }

  static var production: Self {
    URLHost(rawValue: "api.myapp.com")
  }

  public static var `default`: Self {
    #if DEBUG
    return staging
    #else
    return production
    #endif
  }
}
