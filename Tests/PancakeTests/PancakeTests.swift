#if canImport(XCTest)
import XCTest
@testable import Pancake

final class PancakeTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(Pancake().text, "Hello, World!")
    }
}
#endif
