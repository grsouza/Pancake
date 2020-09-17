#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIViewController {
    public var isVisible: Bool {
        isViewLoaded && view.window != nil
    }

    public func add(child: UIViewController, toContainerView containerView: UIView? = nil) {
        addChild(child)
        (containerView ?? view)?.addSubview(child.view)
        child.didMove(toParent: self)
    }

    public func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

#endif
