#if canImport(UIKit)
import UIKit

public final class HStack: View {

  // MARK: Lifecycle

  public init(
    spacing: CGFloat,
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    _ views: [UIView]
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
    spacing: CGFloat,
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    _ views: UIView...
  ) {
    self.init(spacing: spacing, alignment: alignment, distribution: distribution, views)
  }

  public convenience init(
    spacing: CGFloat,
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    _ views: UIView?...
  ) {
    self.init(
      spacing: spacing,
      alignment: alignment,
      distribution: distribution,
      views.compactMap { $0 }
    )
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
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    _ views: [UIView]
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
    spacing: CGFloat,
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    _ views: UIView...
  ) {
    self.init(spacing: spacing, alignment: alignment, distribution: distribution, views)
  }

  public convenience init(
    spacing: CGFloat,
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    _ views: UIView?...
  ) {
    self.init(
      spacing: spacing,
      alignment: alignment,
      distribution: distribution,
      views.compactMap { $0 }
    )
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
