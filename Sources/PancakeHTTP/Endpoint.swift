import Foundation

public struct Endpoint<Kind: EndpointKind, Response: Decodable> {

  // MARK: Lifecycle

  public init(method: HTTP.Method, path: String, queryItems: [URLQueryItem], httpBody: Data?) {
    self.method = method
    self.path = path
    self.queryItems = queryItems
    self.httpBody = httpBody
  }

  public init<Body: Encodable>(
    method: HTTP.Method,
    path: String,
    queryItems: [URLQueryItem],
    httpBody: Body?,
    encoder: JSONEncoder = .init()
  ) throws {
    try self.init(
      method: method,
      path: path,
      queryItems: queryItems,
      httpBody: httpBody.map { try encoder.encode($0) }
    )
  }

  // MARK: Public

  public var method: HTTP.Method
  public var path: String
  public var queryItems: [URLQueryItem]
  public var httpBody: Data?

}

extension Endpoint {
  public func makeRequest(with data: Kind.RequestData, host: URLHost = .default) -> URLRequest? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host.rawValue
    components.path = "/" + path
    components.queryItems = queryItems.isEmpty ? nil : queryItems

    guard let url = components.url else {
      return nil
    }

    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.httpBody = httpBody
    Kind.prepare(&request, with: data)
    return request
  }
}
