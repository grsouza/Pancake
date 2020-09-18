#if canImport(XCTest)
@testable import Pancake
import XCTest

final class PancakeTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(Pancake().text, "Hello, World!")
    }
}
#endif
