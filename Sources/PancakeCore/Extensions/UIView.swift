#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIView {
  /// Returns the first `UIViewController` found in responder chain, or `nil` if none is found.
  public var parentViewController: UIViewController? {
    weak var parentResponder: UIResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder?.next
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
    }
    return nil
  }

  @inlinable
  public func addSubviews(_ views: [UIView]) {
    views.forEach { addSubview($0) }
  }

  @inlinable
  public func addSubviews(_ views: UIView...) {
    addSubviews(views)
  }
}
#endif
