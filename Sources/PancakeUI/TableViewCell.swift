#if canImport(UIKit)
import UIKit

open class TableViewCell: UITableViewCell {

  // MARK: Lifecycle

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    configureSubviews()
    configureConstraints()
    additionalConfigurations()
  }

  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Open

  open func configureSubviews() {}

  open func configureConstraints() {}

  open func additionalConfigurations() {}

}
#endif
