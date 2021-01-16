#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIViewController {
  /// Returns true if the view controller is visible, false otherwise.
  ///
  /// The check is `isViewLoaded && view.window != nil`
  @inlinable
  public var isVisible: Bool {
    isViewLoaded && view.window != nil
  }

  /// Add `child` as a child controller.
  @inlinable
  public func add(child: UIViewController, toContainerView containerView: UIView? = nil) {
    addChild(child)
    (containerView ?? view)?.addSubview(child.view)
    child.didMove(toParent: self)
  }

  /// Remove current controller from a parent controller.
  @inlinable
  public func remove() {
    guard parent != nil else { return }
    willMove(toParent: nil)
    removeFromParent()
    view.removeFromSuperview()
  }

  @inlinable
  public func embededInNavigationController<NavigationController: UINavigationController>(_: NavigationController.Type) -> NavigationController {
    NavigationController(rootViewController: self)
  }

  @inlinable
  public func embededInNavigationController() -> UINavigationController {
    UINavigationController(rootViewController: self)
  }
}

#endif
