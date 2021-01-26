//
//  File.swift
//
//
//  Created by Guilherme Souza on 26/01/21.
//

import XCTest
@testable import PancakeLogging

final class PancakeLoggingTests: XCTestCase {

  func testConsoleLogging() {
    Logger.addDestinations(ConsoleDestination(json: true), FileDestination())
    Logger.custom(level: .debug, message: "This is a debug message")
    Logger.error(message: "error message")
  }
}
