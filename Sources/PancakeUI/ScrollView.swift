#if canImport(UIKit)
  import UIKit

  public struct ScrollView: Stackable {

    // MARK: Lifecycle

    public init(
      _ view: Stackable,
      axis: NSLayoutConstraint.Axis = Defaults.scrollViewAxis
    ) {
      scrollView = UIScrollView()

      let rootView = view.rootView
      scrollView.addSubview(rootView)
      rootView.edgesToSuperview()

      switch axis {
      case .horizontal:
        rootView.heightToSuperview()

      case .vertical:
        rootView.widthToSuperview()

      @unknown default: ()
      }
    }

    // MARK: Public

    public var rootView: UIView { scrollView }

    // MARK: Private

    private let scrollView: UIScrollView
  }
#endif
