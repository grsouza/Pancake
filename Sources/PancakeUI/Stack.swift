#if canImport(UIKit)
import UIKit

public final class HStack: View {

  // MARK: Lifecycle

  public init(
    _ views: [UIView],
    spacing: CGFloat = Defaults.stackSpacing,
    alignment: UIStackView.Alignment = Defaults.stackAlignment,
    distribution: UIStackView.Distribution = Defaults.stackDistribution
  ) {
    super.init()

    stackView.spacing = spacing
    stackView.alignment = alignment
    stackView.distribution = distribution

    views.forEach {
      stackView.addArrangedSubview($0)
    }

    addSubview(stackView)
    stackView.edgesToSuperview()
  }

  public convenience init(
    _ views: UIView...,
    spacing: CGFloat = Defaults.stackSpacing,
    alignment: UIStackView.Alignment = Defaults.stackAlignment,
    distribution: UIStackView.Distribution = Defaults.stackDistribution
  ) {
    self.init(views, spacing: spacing, alignment: alignment, distribution: distribution)
  }

  // MARK: Private

  private let stackView = UIStackView().with {
    $0.axis = .horizontal
  }

}

public final class VStack: View {

  // MARK: Lifecycle

  public init(
    _ views: [UIView],
    spacing: CGFloat = Defaults.stackSpacing,
    alignment: UIStackView.Alignment = Defaults.stackAlignment,
    distribution: UIStackView.Distribution = Defaults.stackDistribution
  ) {
    super.init()

    stackView.spacing = spacing
    stackView.alignment = alignment
    stackView.distribution = distribution

    views.forEach {
      stackView.addArrangedSubview($0)
    }

    addSubview(stackView)
    stackView.edgesToSuperview()
  }

  public convenience init(
    _ views: UIView...,
    spacing: CGFloat = Defaults.stackSpacing,
    alignment: UIStackView.Alignment = Defaults.stackAlignment,
    distribution: UIStackView.Distribution = Defaults.stackDistribution
  ) {
    self.init(views, spacing: spacing, alignment: alignment, distribution: distribution)
  }

  // MARK: Private

  private let stackView = UIStackView().with {
    $0.axis = .vertical
  }

}

extension UIStackView.Alignment: CustomDebugStringConvertible {
  public var debugDescription: String {
    switch self {
    case .fill: return "fill"
    case .leading: return "leading"
    case .firstBaseline: return "firstBaseline"
    case .center: return "center"
    case .trailing: return "trailing"
    case .lastBaseline: return "lastBaseline"
    @unknown default: return "unknown"
    }
  }
}
#endif
