#if canImport(UIKit)
import UIKit

public final class ScrollView: View {

  // MARK: Lifecycle

  public init(
    _ view: UIView,
    axis: NSLayoutConstraint.Axis = Defaults.scrollViewAxis
  ) {
    scrollView = UIScrollView()
    scrollView.addSubview(view)
    view.edgesToSuperview()

    switch axis {
    case .horizontal:
      view.heightToSuperview()

    case .vertical:
      view.widthToSuperview()

    @unknown default: ()
    }

    super.init()

    addSubview(scrollView)
    scrollView.edgesToSuperview()
  }

  // MARK: Private

  private let scrollView: UIScrollView
}
#endif
