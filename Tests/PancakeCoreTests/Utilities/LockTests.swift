import XCTest
@testable import PancakeCore

class LockTests: XCTestCase {

    func testMake_WithiOS10OrAbove_ShouldReturnAnUnfairLock() {
        let lock = Lock.make()

        XCTAssert(lock is Lock.UnfairLock)
    }
}
