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

  public lazy var disposeBag = DisposeBag()

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

    NotificationCenter.default.rx
      .notification(UIApplication.keyboardWillShowNotification)
      .compactMap { notification in
        (notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      }
      .subscribe(onNext: { [weak self] keyboardFrame in
        self?.onKeyboardAppearActions.forEach {
          $0(keyboardFrame)
        }
      })
      .disposed(by: disposeBag)

    NotificationCenter.default.rx
      .notification(UIApplication.keyboardWillHideNotification)
      .compactMap { notification in
        (notification.userInfo?[UIApplication.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
      }
      .subscribe(onNext: { [weak self] keyboardFrame in
        self?.onKeyboardDisappearActions.forEach {
          $0(keyboardFrame)
        }
      })
      .disposed(by: disposeBag)
  }
}
