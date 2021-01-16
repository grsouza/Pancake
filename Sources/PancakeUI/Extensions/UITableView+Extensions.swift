#if canImport(UIKit)
import UIKit

extension UITableViewCell {
  open class var reuseIdentifier: String { "\(self)" }
}

extension UITableView {

  public func register<Cell: UITableViewCell>(_: Cell.Type) {
    register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
  }

  public func dequeueReusableCell<Cell: UITableViewCell>(_: Cell.Type, for indexPath: IndexPath) -> Cell {
    guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
      fatalError()
    }

    return cell
  }
}
#endif
