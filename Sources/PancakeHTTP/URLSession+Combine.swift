import Combine
import Foundation

extension URLSession {
  @available(OSX 10.15, *)
  public func publisher<K, R>(
    for endpoint: Endpoint<K, R>,
    using requestData: K.RequestData,
    decoder: JSONDecoder = .init()
  ) -> AnyPublisher<R, Error> {
    guard let request = endpoint.makeRequest(with: requestData) else {
      return Fail(
        error: Errors.invalidEndpoint
      ).eraseToAnyPublisher()
    }

    return dataTaskPublisher(for: request)
      .map(\.data)
      .decode(type: R.self, decoder: decoder)
      .eraseToAnyPublisher()
  }
}
