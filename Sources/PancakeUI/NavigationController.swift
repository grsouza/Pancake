#if canImport(UIKit)
  import UIKit

  open class NavigationController: UINavigationController {

    // MARK: Open

    open override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)

      if isBeingDismissed || isMovingFromParent {
        didFinish?()
      }
    }

    // MARK: Public

    public var didFinish: (() -> Void)?

  }
#endif
