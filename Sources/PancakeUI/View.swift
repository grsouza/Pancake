import UIKit

open class View: UIView {

  // MARK: Lifecycle

  public init() {
    super.init(frame: .zero)

    setupKeyboardNotifications()

    configureSubviews()
    configureConstraints()
    additionalConfigurations()
  }

  @available(*, unavailable)
  public required init?(
    coder: NSCoder
  ) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Open

  open func configureSubviews() {}

  open func configureConstraints() {}

  open func additionalConfigurations() {}

  // MARK: Public

  @discardableResult
  public func onKeyboardAppear(_ action: @escaping (CGRect) -> Void) -> Self {
    onKeyboardAppearActions.append(action)
    return self
  }

  @discardableResult
  public func onKeyboardDisappear(_ action: @escaping (CGRect) -> Void) -> Self {
    onKeyboardDisappearActions.append(action)
    return self
  }

  // MARK: Private

  private var onKeyboardAppearActions: [(CGRect) -> Void] = []

  private var onKeyboardDisappearActions: [(CGRect) -> Void] = []

  // MARK: - Keyboard
  private func setupKeyboardNotifications() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIApplication.keyboardWillShowNotification,
      object: nil
    )

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIApplication.keyboardWillHideNotification,
      object: nil
    )
  }

  @objc
  private func keyboardWillShow(notification: Notification) {
    guard
      let keyboardFrame =
      (notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? NSValue)?
        .cgRectValue
    else { return }

    onKeyboardAppearActions.forEach {
      $0(keyboardFrame)
    }
  }

  @objc
  private func keyboardWillHide(notification: Notification) {
    guard
      let keyboardFrame =
      (notification.userInfo?[UIApplication.keyboardFrameBeginUserInfoKey] as? NSValue)?
        .cgRectValue
    else { return }

    onKeyboardDisappearActions.forEach {
      $0(keyboardFrame)
    }
  }

}
