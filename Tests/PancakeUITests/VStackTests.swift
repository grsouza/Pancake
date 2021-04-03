#if canImport(UIKit)
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
        views,
        spacing: 10,
        alignment: .fill,
        distribution: .fill
      ).rootView.with {
        $0.width(256)
        $0.backgroundColor = .white
      }

      assertSnapshot(matching: stack, as: .image)
    }

    func testVStackCustomAlignment() {
      let view1 = UIView().with {
        $0.width(100)
        $0.height(32)
        $0.backgroundColor = .darkGray
      }

      let view2 = UIView().with {
        $0.width(80)
        $0.height(32)
        $0.backgroundColor = .darkGray
      }

      let view3 = UIView().with {
        $0.width(120)
        $0.height(32)
        $0.backgroundColor = .darkGray
      }

      let alignments: [UIStackView.Alignment] = [.leading, .center, .trailing]

      for alignment in alignments {
        let stack = VStack(
          view1, view2, view3,
          spacing: 10,
          alignment: alignment
        ).rootView.with {
          $0.width(256)
          $0.backgroundColor = .white
        }

        assertSnapshot(matching: stack, as: .image, named: alignment.debugDescription)
      }
    }
  }
#endif
