#if canImport(UIKit)
import UIKit

public protocol Stackable {
  var rootView: UIView { get }
}

extension UIView: Stackable {
  public var rootView: UIView { self }
}

public struct HStack: Stackable {

  // MARK: Lifecycle

  public init(
    _ views: [Stackable],
    spacing: CGFloat = Defaults.stackSpacing,
    alignment: UIStackView.Alignment = Defaults.stackAlignment,
    distribution: UIStackView.Distribution = Defaults.stackDistribution
  ) {
    stackView.spacing = spacing
    stackView.alignment = alignment
    stackView.distribution = distribution

    views.forEach {
      stackView.addArrangedSubview($0.rootView)
    }
  }

  public init(
    _ views: Stackable...,
    spacing: CGFloat = Defaults.stackSpacing,
    alignment: UIStackView.Alignment = Defaults.stackAlignment,
    distribution: UIStackView.Distribution = Defaults.stackDistribution
  ) {
    self.init(views, spacing: spacing, alignment: alignment, distribution: distribution)
  }

  // MARK: Public

  public var rootView: UIView { stackView }

  // MARK: Private

  private let stackView = UIStackView().with {
    $0.axis = .horizontal
  }

}

public struct VStack: Stackable {

  // MARK: Lifecycle

  public init(
    _ views: [Stackable],
    spacing: CGFloat = Defaults.stackSpacing,
    alignment: UIStackView.Alignment = Defaults.stackAlignment,
    distribution: UIStackView.Distribution = Defaults.stackDistribution
  ) {
    stackView.spacing = spacing
    stackView.alignment = alignment
    stackView.distribution = distribution

    views.forEach {
      stackView.addArrangedSubview($0.rootView)
    }
  }

  public init(
    _ views: Stackable...,
    spacing: CGFloat = Defaults.stackSpacing,
    alignment: UIStackView.Alignment = Defaults.stackAlignment,
    distribution: UIStackView.Distribution = Defaults.stackDistribution
  ) {
    self.init(views, spacing: spacing, alignment: alignment, distribution: distribution)
  }

  // MARK: Public

  public var rootView: UIView { stackView }

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
