#if canImport(UIKit)
import UIKit

public final class TextField: View {

  // MARK: Lifecycle

  public init(
    contentType: ContentType = .default,
    placeholder: String? = nil,
    onEditChanged: ((TextField) -> Void)? = nil
  ) {
    self.contentType = contentType
    self.onEditChanged = onEditChanged
    super.init()

    textField.placeholder = placeholder
    textField.borderStyle = .roundedRect

    textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
  }

  // MARK: Public

  public var text: String? {
    textField.text
  }

  public override func configureSubviews() {
    super.configureSubviews()
    addSubview(textField)
  }

  public override func configureConstraints() {
    super.configureConstraints()
    textField.height(48)
  }

  public override func additionalConfigurations() {
    super.additionalConfigurations()

    textField.textContentType = textContentType
    textField.keyboardType = keyboardType
    textField.autocorrectionType = autocorrectionType
    textField.autocapitalizationType = autocapitalizationType
    textField.isSecureTextEntry = contentType == .password
  }

  // MARK: Private

  private let textField = UITextField()
  private let onEditChanged: ((TextField) -> Void)?

  private let contentType: ContentType

  private var textContentType: UITextContentType? {
    switch contentType {
    case .email: return .emailAddress
    case .password: if #available(iOS 11.0, *) {
      return .password
    } else {
      return nil
    }
    case .money, .default: return nil
    }
  }

  private var keyboardType: UIKeyboardType {
    switch contentType {
    case .email: return .emailAddress
    case .password, .default: return .default
    case .money: return .numberPad
    }
  }

  private var autocorrectionType: UITextAutocorrectionType {
    switch contentType {
    case .email, .password, .money:
      return .no
    case .default:
      return .yes
    }
  }

  private var autocapitalizationType: UITextAutocapitalizationType {
    switch contentType {
    case .email, .password, .money:
      return .none

    case .default:
      return .sentences
    }
  }

  @objc
  private func editingChanged() {
    onEditChanged?(self)
  }

}

extension TextField {
  public enum ContentType {
    case `default`, email, password, money
  }
}
#endif
