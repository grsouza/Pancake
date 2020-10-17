#if canImport(UIKit)
import UIKit

public final class Space: View {

  public init(fixedWidth: CGFloat? = nil, fixedHeight: CGFloat? = nil) {
    super.init()

    if let fixedWidth = fixedWidth {
      width(fixedWidth)
    }

    if let fixedHeight = fixedHeight {
      height(fixedHeight)
    }
  }
}
#endif
