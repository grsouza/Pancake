import XCTest
@testable import PancakeCore

final class WeakTests: XCTestCase {
  func testWeakClass() {
    let weak = Weak<BarClass>()

    _ = {
      let strong = BarClass()
      weak.value = strong
    }()

    XCTAssertNil(weak.value)
  }

  func testWeakProtocol() {
    let weak = Weak<FooProtocol>()

    _ = {
      let strong = BarClass()
      weak.value = strong as FooProtocol
    }()

    XCTAssertNil(weak.value)
  }

  func testCollectionOfWeakObjects() {
    let array = Array(repeating: Weak<BarClass>(), count: 10)

    _ = {
      let strongObjects = Array(repeating: BarClass(), count: 10)

      array.enumerated().forEach { index, _ in
        array[index].value = strongObjects[index]
      }
    }()

    array.forEach {
      XCTAssertNil($0.value)
    }
  }
}

protocol FooProtocol {}

class BarClass: FooProtocol {}
