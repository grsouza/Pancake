#if canImport(UIKit)
import UIKit

public final class SafeArea: View {

  public init(
    _ view: UIView
  ) {
    super.init()

    addSubview(view)
    view.edgesToSuperview(usingSafeArea: true)
  }
}
#endif
