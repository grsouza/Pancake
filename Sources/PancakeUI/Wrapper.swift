#if canImport(UIKit)
import UIKit

public final class Wrapper: View {

  // MARK: Lifecycle

  public init(_ view: UIView, alignment: Alignment = .all, usingSafeArea: Bool = false) {
    super.init()

    addSubview(view)

    if alignment.contains(.top) {
      view.topToSuperview(usingSafeArea: usingSafeArea)
    }

    if alignment.contains(.trailing) {
      view.trailingToSuperview(usingSafeArea: usingSafeArea)
    }

    if alignment.contains(.bottom) {
      view.bottomToSuperview(usingSafeArea: usingSafeArea)
    }

    if alignment.contains(.leading) {
      view.leadingToSuperview(usingSafeArea: usingSafeArea)
    }

    if alignment.contains(.centerX) {
      view.centerXToSuperview(usingSafeArea: usingSafeArea)
    }

    if alignment.contains(.centerY) {
      view.centerYToSuperview(usingSafeArea: usingSafeArea)
    }
  }

  // MARK: Public

  public struct Alignment: OptionSet {
    public let rawValue: UInt8

    public init(rawValue: UInt8) {
      self.rawValue = rawValue
    }

    public static let top = Alignment(rawValue: 1 << 0)
    public static let trailing = Alignment(rawValue: 1 << 1)
    public static let bottom = Alignment(rawValue: 1 << 2)
    public static let leading = Alignment(rawValue: 1 << 3)
    public static let centerX = Alignment(rawValue: 1 << 4)
    public static let centerY = Alignment(rawValue: 1 << 5)
    public static let all: Alignment = [.top, .trailing, .bottom, .leading, .centerX, .centerY]
  }

}

extension Wrapper.Alignment: CustomDebugStringConvertible {
  public var debugDescription: String {
    var values: [String] = []

    if contains(.top) {
      values.append("top")
    }

    if contains(.trailing) {
      values.append("trailing")
    }

    if contains(.bottom) {
      values.append("bottom")
    }

    if contains(.leading) {
      values.append("leading")
    }

    if contains(.centerX) {
      values.append("centerX")
    }

    if contains(.centerY) {
      values.append("centerY")
    }

    return values.joined(separator: "-")
  }
}

#endif
