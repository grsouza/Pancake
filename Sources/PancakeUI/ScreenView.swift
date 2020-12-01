#if canImport(UIKit)
import UIKit

public final class ScreenView: View {

  // MARK: Lifecycle

  public init(
    header: UIView?,
    content: UIView?,
    footer: UIView?
  ) {
    stackView = VStack(
      [
        header,
        content.map(SafeArea.init),
        footer,
      ].compactMap { $0 },
      spacing: 0
    )

    super.init()

    onKeyboardAppear { frame in
      self.bottomConstraint?.constant = -frame.height
    }

    onKeyboardDisappear { _ in
      self.bottomConstraint?.constant = 0
    }
  }

  // MARK: Public

  public override func configureSubviews() {
    super.configureSubviews()

    addSubview(stackView.rootView)
  }

  public override func configureConstraints() {
    super.configureConstraints()

    bottomConstraint = stackView.rootView.edgesToSuperview().last
  }

  // MARK: Private

  private let stackView: Stackable

  private var bottomConstraint: NSLayoutConstraint?

}
#endif
