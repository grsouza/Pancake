import UIKit

public final class ScrollView: View {

  // MARK: Lifecycle

  public init(
    axis: NSLayoutConstraint.Axis,
    _ view: UIView
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
