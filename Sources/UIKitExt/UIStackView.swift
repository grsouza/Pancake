#if canImport(UIKit) && !os(watchOS)
  import UIKit

  extension UIStackView {
    @inlinable
    public func addArrangedSubviews(_ views: [UIView]) {
      views.forEach { addArrangedSubview($0) }
    }

    @inlinable
    public func addArrangedSubviews(_ views: UIView...) {
      addArrangedSubviews(views)
    }
  }

#endif
