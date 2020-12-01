#if canImport(UIKit)
import UIKit

public struct Padding: Stackable {

  public init(
    _ view: Stackable,
    insets: UIEdgeInsets = Defaults.padding
  ) {
    rootView.addSubview(view.rootView)
    view.rootView.edgesToSuperview(insets: insets)
  }

  public var rootView: UIView = UIView()
}
#endif
