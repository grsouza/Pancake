import UIKit

public final class Blur: View {

  // MARK: Lifecycle

  init(
    style: UIBlurEffect.Style = .prominent,
    _ childView: UIView
  ) {
    effect = UIBlurEffect(style: style)
    self.childView = childView
    super.init()
  }

  // MARK: Public

  public override func configureSubviews() {
    addSubview(blurEffectView)
    addSubview(childView)
  }

  public override func configureConstraints() {
    blurEffectView.edgesToSuperview()
    childView.edgesToSuperview()
  }

  // MARK: Private

  private let childView: UIView

  private let effect: UIBlurEffect
  private lazy var blurEffectView = UIVisualEffectView(effect: effect)
}