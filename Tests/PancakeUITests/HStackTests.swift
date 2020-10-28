import PancakeUI
import SnapshotTesting
import UIKit
import XCTest

final class HStackTests: XCTestCase {

  func testHStack() {
    let views = (0..<10).map { _ in
      UIView().with {
        $0.width(32)
        $0.backgroundColor = .darkGray
      }
    }

    let stack = HStack(
      spacing: 10,
      alignment: .fill,
      distribution: .fill,
      views
    ).with {
      $0.height(32)
      $0.backgroundColor = .white
    }

    assertSnapshot(matching: stack, as: .image)
  }

  func testHStackCustomAlignment() {
    let view1 = UIView().with {
      $0.height(100)
      $0.width(32)
      $0.backgroundColor = .darkGray
    }

    let view2 = UIView().with {
      $0.height(80)
      $0.width(32)
      $0.backgroundColor = .darkGray
    }

    let view3 = UIView().with {
      $0.height(120)
      $0.width(32)
      $0.backgroundColor = .darkGray
    }

    let alignments: [UIStackView.Alignment] = [.top, .center, .bottom]

    for alignment in alignments {
      let stack = HStack(
        spacing: 10,
        alignment: alignment,
        view1, view2, view3
      ).with {
        $0.height(128)
        $0.backgroundColor = .white
      }

      assertSnapshot(matching: stack, as: .image, named: alignment.debugDescription)
    }
  }
}
