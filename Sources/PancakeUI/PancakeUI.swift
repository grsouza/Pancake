@_exported import PancakeCore
@_exported import TinyConstraints
import UIKit

public enum Defaults {
  public static var padding: UIEdgeInsets = .uniform(20)
  public static var blurStyle: UIBlurEffect.Style = .prominent
  public static var scrollViewAxis: NSLayoutConstraint.Axis = .vertical
  public static var stackSpacing: CGFloat = 16
  public static var stackAlignment: UIStackView.Alignment = .fill
  public static var stackDistribution: UIStackView.Distribution = .fill
}
