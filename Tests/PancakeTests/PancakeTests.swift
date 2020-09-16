import XCTest
@testable import Pancake

final class PancakeTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(Pancake().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
