import UIKit

final class NavigationController: UINavigationController {

  var didFinish: (() -> Void)?

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    if isBeingDismissed || isMovingFromParent {
      didFinish?()
    }
  }
}
