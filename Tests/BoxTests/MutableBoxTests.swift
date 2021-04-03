import XCTest

@testable import Box

final class MutableBoxTests: XCTestCase {

  var box = MutableBox(Value(name: "Box"))

  func testMutableBox() {
    let box2 = box

    let boxAddress = address(of: &box.wrappedValue)
    let box2Address = address(of: &box2.wrappedValue)

    XCTAssertEqual(boxAddress, box2Address)

    box.wrappedValue.name = "New Box"

    XCTAssertEqual(box2.wrappedValue.name, "New Box")
  }

  func testMutableBox_customStringConvertible() {
    XCTAssertEqual("\(box)", "MutableBox(Value: Box)")
    box.wrappedValue.name = "New Box"
    XCTAssertEqual("\(box)", "MutableBox(Value: New Box)")
  }
}
