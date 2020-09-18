@testable import PancakeCore
import XCTest

class LockTests: XCTestCase {
    func testMake_WithiOS10OrAbove_ShouldReturnAnUnfairLock() {
        let lock = Lock.make()

        XCTAssert(lock is Lock.UnfairLock)
    }
}
