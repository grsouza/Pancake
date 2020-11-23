//
//  File.swift
//
//
//  Created by Guilherme Souza on 20/11/20.
//

import PancakeCore
import XCTest

final class ArrayTests: XCTestCase {

  func testPrepend() {
    var array = [1, 2, 3]
    array.prepend(0)

    XCTAssertEqual(array, [0, 1, 2, 3])
  }

  func testPrependCollection() {
    var array = [3, 4, 5]
    array.prepend(contentsOf: [0, 1, 2])

    XCTAssertEqual(array, [0, 1, 2, 3, 4, 5])
  }
}
