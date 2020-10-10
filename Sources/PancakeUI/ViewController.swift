import UIKit

open class ViewController: UIViewController {

  // MARK: Lifecycle

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  var didFinish: (() -> Void)?

  open override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }

  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    if isBeingDismissed || isMovingFromParent {
      didFinish?()
    }
  }
}
