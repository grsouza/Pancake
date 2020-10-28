import PancakeUI
import SnapshotTesting
import UIKit
import XCTest

final class VStackTests: XCTestCase {

  func testVStack() {
    let views = (0..<10).map { _ in
      UIView().with {
        $0.height(32)
        $0.backgroundColor = .darkGray
      }
    }

    let stack = VStack(
      spacing: 10,
      alignment: .fill,
      distribution: .fill,
      views
    ).with {
      $0.width(256)
      $0.backgroundColor = .white
    }

    assertSnapshot(matching: stack, as: .image)
  }
}
