import XCTest

@testable import Box

final class BoxTests: XCTestCase {

  var box = Box(Value(name: "Box"))

  func testBox() {
    let box2 = box

    let boxAddress = address(of: &box.wrappedValue)
    let box2Address = address(of: &box2.wrappedValue)

    XCTAssertEqual(boxAddress, box2Address)
  }

  func testBox_customStringConvertible() {
    XCTAssertEqual("\(box)", "Box(Value: Box)")
  }
}

func address(of value: UnsafeRawPointer) -> Int {
  return Int(bitPattern: value)
}

struct Value: CustomStringConvertible {
  var name: String

  var description: String {
    "Value: \(name)"
  }
}
