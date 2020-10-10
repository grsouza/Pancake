import PancakeHTTP
import XCTest

extension EndpointKinds {
  enum Stub: EndpointKind {
    static func prepare(_ request: inout URLRequest, with data: Void) {
      // no-op
    }
  }
}

extension URLHost {
  func expectedURL(withPath path: String) throws -> URL {
    let url = URL(string: "https://" + rawValue + "/" + path)
    return try XCTUnwrap(url)
  }
}

class EndpointTests: XCTestCase {
  typealias StubbedEndpoint = Endpoint<EndpointKinds.Stub, String>

  let host = URLHost(rawValue: "test")

  func testBasicRequestGeneration() throws {
    let endpoint = StubbedEndpoint(
      method: .get,
      path: "path",
      queryItems: [],
      httpBody: nil
    )

    let request = try XCTUnwrap(endpoint.makeRequest(with: (), host: host))
    try XCTAssertEqual(request.url, host.expectedURL(withPath: "path"))
    XCTAssertEqual(request.httpMethod, "GET")
    XCTAssertNil(request.httpBody)
  }

  func testGenerationRequestWithQueryItems() throws {
    let endpoint = StubbedEndpoint(
      method: .get,
      path: "path",
      queryItems: [
        URLQueryItem(name: "a", value: "1"),
        URLQueryItem(name: "b", value: "2"),
      ],
      httpBody: nil
    )

    let request = try XCTUnwrap(endpoint.makeRequest(with: (), host: host))
    try XCTAssertEqual(request.url, host.expectedURL(withPath: "path?a=1&b=2"))
  }

  func testGenerationRequestWithBody() throws {
    let httpBody = try XCTUnwrap("{\"data\": \"Test data\"}".data(using: .utf8))
    let endpoint = StubbedEndpoint(
      method: .post,
      path: "path",
      queryItems: [],
      httpBody: httpBody
    )

    let request = try XCTUnwrap(endpoint.makeRequest(with: (), host: host))
    XCTAssertEqual(request.httpBody, httpBody)
  }

  func testGenerationRequestWithEncodableBody() throws {
    let exampleModel = ExampleModel(data: "Test data")
    let endpoint = try StubbedEndpoint(
      method: .post,
      path: "path",
      queryItems: [],
      httpBody: exampleModel
    )

    let request = try XCTUnwrap(endpoint.makeRequest(with: (), host: host))
    try XCTAssertEqual(request.httpBody, JSONEncoder().encode(exampleModel))
  }
}

struct ExampleModel: Encodable {
  let data: String
}
