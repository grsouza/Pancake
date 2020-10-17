#if canImport(UIKit)
import UIKit

open class Button: UIButton {

  // MARK: Lifecycle

  public init(
    title: String?,
    onTouchUpInside: @escaping () -> Void
  ) {
    self.title = title
    self.onTouchUpInside = onTouchUpInside

    super.init(frame: .zero)

    addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
    setupStyle()
  }

  @available(*, unavailable)
  public required init?(
    coder: NSCoder
  ) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Open

  open func setupStyle() {
    UIView.performWithoutAnimation {
      setTitle(title, for: .normal)
    }
  }

  @objc
  open func didTouchUpInside() {
    onTouchUpInside()
  }

  // MARK: Public

  public let title: String?
  public let onTouchUpInside: () -> Void

}
#endif
