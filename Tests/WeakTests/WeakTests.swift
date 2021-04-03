import XCTest
import Weak

final class WeakTests: XCTestCase {
    func testWeakClass() {
        let weak = Weak<BarClass>()

        _ = {
            let strong = BarClass()
            weak.wrappedValue = strong
        }()

        XCTAssertNil(weak.wrappedValue)
    }

    func testWeakProtocol() {
        let weak = Weak<FooProtocol>()

        _ = {
            let strong = BarClass()
            weak.wrappedValue = strong as FooProtocol
        }()

        XCTAssertNil(weak.wrappedValue)
    }

    func testCollectionOfWeakObjects() {
        let array = Array(repeating: Weak<BarClass>(), count: 10)

        _ = {
            let strongObjects = Array(repeating: BarClass(), count: 10)

            array.enumerated().forEach { index, _ in
                array[index].wrappedValue = strongObjects[index]
            }
        }()

        array.forEach {
            XCTAssertNil($0.wrappedValue)
        }
    }
}

protocol FooProtocol {}

class BarClass: FooProtocol {}
