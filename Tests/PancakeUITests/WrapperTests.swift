#if canImport(UIKit)
import PancakeUI
import SnapshotTesting
import UIKit
import XCTest

final class WrapperTests: XCTestCase {

  func testWrapperTopAlignment() {
    let view = UIView().with {
      $0.backgroundColor = .darkGray
      $0.size(CGSize(width: 32, height: 32))
    }

    let alignments: [Wrapper.Alignment] = [
      .top,
      .trailing,
      .bottom,
      .leading,
      .centerX,
      .centerY,
      [.top, .leading],
      [.top, .trailing],
      [.bottom, .leading],
      [.bottom, .trailing],
      [.centerX, .top],
      [.centerX, .bottom],
      [.centerY, .leading],
      [.centerY, .trailing],
    ]

    for alignment in alignments {
      let wrapper = Wrapper(view, alignment: alignment).with {
        $0.size(CGSize(width: 64, height: 64))
        $0.backgroundColor = .white
      }

      assertSnapshot(matching: wrapper, as: .image, named: alignment.debugDescription)
    }
  }

}
#endif
