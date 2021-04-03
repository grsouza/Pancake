import XCTest

@testable import Lock

class LockTests: XCTestCase {
  func testMake_WithiOS10OrAbove_ShouldReturnAnUnfairLock() {
    let lock = Lock.make()

    XCTAssert(lock is UnfairLock)
  }
}
