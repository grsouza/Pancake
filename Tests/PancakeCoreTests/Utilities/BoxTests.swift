import XCTest
@testable import PancakeCore

class BoxTestCase: XCTestCase {
  func testBox_ShouldWrapValue() {
    let value = 1337
    let box = Box<Int>(value)

    XCTAssertEqual(value, box.value)
  }

  func testMutableBox_ShouldWrapValueAndAllowModifying() {
    let value = 1337
    let varBox = MutableBox<Int>(value)

    XCTAssertEqual(value, varBox.value)

    let newValue = 7331
    varBox.value = newValue

    XCTAssertEqual(newValue, varBox.value)
  }

  func testBox_ShouldEncodeAndDecode() {
    struct Value: Codable, Equatable {
      let box: Box<Int>
    }

    let data = "{\"box\":1}".data(using: .utf8)!
    let value = try! JSONDecoder().decode(Value.self, from: data)

    XCTAssertEqual(Value(box: Box(1)), value)

    let encodedData = try! JSONEncoder().encode(value)
    XCTAssertEqual(data, encodedData)
  }

  func testMutableBox_ShouldEncodeAndDecode() {
    struct Value: Codable, Equatable {
      let box: MutableBox<Int>
    }

    let data = "{\"box\":1}".data(using: .utf8)!
    let value = try! JSONDecoder().decode(Value.self, from: data)

    XCTAssertEqual(Value(box: MutableBox(1)), value)

    let encodedData = try! JSONEncoder().encode(value)
    XCTAssertEqual(data, encodedData)
  }
}
