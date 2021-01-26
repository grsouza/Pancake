//
//  File.swift
//
//
//  Created by Guilherme Souza on 20/11/20.
//

#if canImport(UIKit)
import PancakeCore
import UIKit

public final class FormToolbar {

  // MARK: Lifecycle

  public init() {}

  // MARK: Public

  /// Set the text fields that will be controlled by FormController
  /// - Parameter newTextFields: Array of text fields controlled by the form, the FormController does not holds a strong reference to the text fields.
  public func setTextFields(_ newTextFields: [UITextField]) {
    textFields = newTextFields.map(Weak.init)

    newTextFields.forEach { field in
      field.inputAccessoryView = toolbar
      field.addTarget(self, action: #selector(editingDidEndOnExit), for: .editingDidEndOnExit)
      field.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
    }
  }

  // MARK: Private

  private var textFields: [Weak<UITextField>] = []

  private lazy var previousButton = UIBarButtonItem(
    image: UIImage(),
    style: .plain,
    target: self,
    action: #selector(didPressPreviousButton)
  )

  private lazy var nextButton = UIBarButtonItem(
    image: UIImage(),
    style: .plain,
    target: self,
    action: #selector(didPressNextButton)
  )

  private lazy var toolbar = UIToolbar(frame: CGRect(
    x: 0,
    y: 0,
    width: UIScreen.main.bounds.width,
    height: 44
  )).with {
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let done = UIBarButtonItem(
      title: "OK",
      style: .done,
      target: self,
      action: #selector(didPressDoneButton)
    )

    $0.items = [previousButton, nextButton, space, done]
  }

  private var currentTextField: UITextField? {
    textFields.first { $0.value?.isFirstResponder ?? false }?.value
  }

  private var currentTextFieldIndex: Int? {
    textFields.firstIndex { $0.value?.isFirstResponder ?? false }
  }

  private var previousTextFieldIndex: Int? {
    guard let currentTextFieldIndex = currentTextFieldIndex else { return nil }

    guard currentTextFieldIndex > 0 && currentTextFieldIndex < textFields.count else {
      return nil
    }

    return currentTextFieldIndex - 1
  }

  private var previousTextField: UITextField? {
    previousTextFieldIndex.map { textFields[$0] }?.value
  }

  private var nextTextFieldIndex: Int? {
    guard let currentTextFieldIndex = currentTextFieldIndex else { return nil }

    guard currentTextFieldIndex >= 0 && currentTextFieldIndex < textFields.count - 1 else {
      return nil
    }

    return currentTextFieldIndex + 1
  }

  private var nextTextField: UITextField? {
    nextTextFieldIndex.map { textFields[$0] }?.value
  }

  @objc
  private func editingDidBegin(textField: UITextField) {
    previousButton.isEnabled = previousTextField != nil
    nextButton.isEnabled = nextTextField != nil
  }

  @objc
  private func editingDidEndOnExit(textField: UITextField) {
    nextTextField?.becomeFirstResponder()
  }

  @objc
  private func didPressPreviousButton() {
    previousTextField?.becomeFirstResponder()
  }

  @objc
  private func didPressNextButton() {
    nextTextField?.becomeFirstResponder()
  }

  @objc
  private func didPressDoneButton() {
    currentTextField?.resignFirstResponder()
  }
}

#endif
