import XCTest

@testable import PancakeCore

final class OptionalTests: XCTestCase {

  struct DummyError: Error, Equatable {}

  func testUnwrap() {
    var optional: String? = "value"
    let unwrapped = try? optional.unwrap(or: DummyError())
    XCTAssertEqual(optional, unwrapped)

    do {
      optional = nil
      _ = try optional.unwrap(or: DummyError())
      XCTFail()
    } catch let error as DummyError {
      XCTAssertEqual(error, DummyError())
    } catch {
      XCTFail()
    }
  }

  func testIsNilOrEmpty() {
    var optionalCollection: [String]? = ["1"]
    XCTAssertFalse(optionalCollection.isNilOrEmpty)

    optionalCollection = []
    XCTAssertTrue(optionalCollection.isNilOrEmpty)

    optionalCollection = nil
    XCTAssertTrue(optionalCollection.isNilOrEmpty)
  }
}
