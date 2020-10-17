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
      spacing: 0,
      header,
      content.map(SafeArea.init),
      footer
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

    addSubview(stackView)
  }

  public override func configureConstraints() {
    super.configureConstraints()

    bottomConstraint = stackView.edgesToSuperview().last
  }

  // MARK: Private

  private let stackView: UIView

  private var bottomConstraint: NSLayoutConstraint?

}
#endif
