//
//  File.swift
//
//
//  Created by Guilherme Souza on 20/11/20.
//

import PancakeCore
import SnapshotTesting
import XCTest

enum TestStorageKey: StorageKey {
  static var defaultValue: String { "test_storage_value" }
}

final class StorageTests: XCTestCase {

  func testShouldReturnDefaultValue() {
    let storage = Storage()
    XCTAssertEqual(storage[TestStorageKey.self], TestStorageKey.defaultValue)
  }

  func testShouldReturnAssignedValue() {
    let storage = Storage()

    let newValue = "new value"
    storage[TestStorageKey.self] = newValue
    XCTAssertEqual(storage[TestStorageKey.self], newValue)
  }

  func testContains() {
    let storage = Storage()
    XCTAssertFalse(storage.contains(TestStorageKey.self))

    storage[TestStorageKey.self] = "new value"

    XCTAssertTrue(storage.contains(TestStorageKey.self))
  }
}
