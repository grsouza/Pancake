#if canImport(UIKit)
import UIKit

public final class HStack: View {

  // MARK: Lifecycle

  public init(
    spacing: CGFloat,
    _ views: [UIView]
  ) {
    super.init()

    stackView.spacing = spacing

    views.forEach {
      stackView.addArrangedSubview($0)
    }

    addSubview(stackView)
    stackView.edgesToSuperview()
  }

  public convenience init(
    spacing: CGFloat,
    _ views: UIView...
  ) {
    self.init(spacing: spacing, views)
  }

  // MARK: Private

  private let stackView = UIStackView().with {
    $0.axis = .horizontal
  }

}

public final class VStack: View {

  // MARK: Lifecycle

  public init(
    spacing: CGFloat,
    _ views: [UIView]
  ) {
    super.init()

    stackView.spacing = spacing

    views.forEach {
      stackView.addArrangedSubview($0)
    }

    addSubview(stackView)
    stackView.edgesToSuperview()
  }

  public convenience init(
    spacing: CGFloat,
    _ views: UIView...
  ) {
    self.init(spacing: spacing, views)
  }

  public convenience init(
    spacing: CGFloat,
    _ views: UIView?...
  ) {
    self.init(spacing: spacing, views.compactMap { $0 })
  }

  // MARK: Private

  private let stackView = UIStackView().with {
    $0.axis = .vertical
  }

}
#endif
