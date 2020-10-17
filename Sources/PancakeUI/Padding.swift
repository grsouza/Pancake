#if canImport(UIKit)
import UIKit

public final class Padding: View {

  public init(
    _ view: UIView,
    insets: UIEdgeInsets
  ) {
    super.init()

    addSubview(view)
    view.edgesToSuperview(insets: insets)
  }
}
#endif
