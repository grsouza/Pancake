#if canImport(UIKit)
import UIKit

open class View: UIView {

  // MARK: Lifecycle

  public init() {
    super.init(frame: .zero)

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
    if !keyboardNotificationAdded {
      setupKeyboardNotifications()
    }
    onKeyboardAppearActions.append(action)
    return self
  }

  @discardableResult
  public func onKeyboardDisappear(_ action: @escaping (CGRect) -> Void) -> Self {
    if !keyboardNotificationAdded {
      setupKeyboardNotifications()
    }
    onKeyboardDisappearActions.append(action)
    return self
  }

  // MARK: Private

  private var keyboardNotificationAdded = false

  private var onKeyboardAppearActions: [(CGRect) -> Void] = []

  private var onKeyboardDisappearActions: [(CGRect) -> Void] = []

  private func setupKeyboardNotifications() {
    keyboardNotificationAdded = true

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
  private func keyboardWillShow(_ notification: Notification) {
    guard let keyboardFrame = (notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
      return
    }

    onKeyboardAppearActions.forEach {
      $0(keyboardFrame)
    }
  }

  @objc
  private func keyboardWillHide(_ notification: Notification) {
    guard let keyboardFrame = (notification.userInfo?[UIApplication.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
      return
    }

    onKeyboardDisappearActions.forEach {
      $0(keyboardFrame)
    }
  }
}
#endif
