import Foundation

public protocol EndpointKind {
  associatedtype RequestData

  static func prepare(_ request: inout URLRequest, with data: RequestData)
}

public enum EndpointKinds {
  public enum Public: EndpointKind {
    public static func prepare(_ request: inout URLRequest, with _: Void) {
      // Here we can do things like assign a custom cache
      // policy for loading our publicly available data.
      // In this example we're telling URLSession not to
      // use any locally cached data for these requests:
      request.cachePolicy = .reloadIgnoringLocalCacheData
    }
  }

  public enum Private: EndpointKind {
    public static func prepare(_ request: inout URLRequest, with token: AccessToken) {
      // For our private endpoints, we'll require an
      // access token to be passed, which we then use to
      // assign an Authorization header to each request:
      request.addValue(
        "Bearer \(token.rawValue)",
        forHTTPHeaderField: "Authorization"
      )
    }
  }
}

public struct AccessToken: RawRepresentable {
  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }
}
