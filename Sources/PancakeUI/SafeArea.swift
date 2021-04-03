#if canImport(UIKit)
  import UIKit

  public final class SafeArea: View {

    public init(
      _ view: Stackable
    ) {
      super.init()

      addSubview(view.rootView)
      view.rootView.edgesToSuperview(usingSafeArea: true)
    }
  }
#endif
