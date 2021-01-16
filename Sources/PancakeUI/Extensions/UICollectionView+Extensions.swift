#if canImport(UIKit)
import UIKit

extension UICollectionViewCell {
  open class var reuseIdentifier: String { "\(self)" }
}

extension UICollectionView {
  public func register<Cell: UICollectionViewCell>(_: Cell.Type) {
    register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
  }

  public func dequeueReusableCell<Cell: UICollectionViewCell>(
    _: Cell.Type,
    for indexPath: IndexPath
  ) -> Cell {
    guard let cell = dequeueReusableCell(
      withReuseIdentifier: Cell.reuseIdentifier,
      for: indexPath
    ) as? Cell else {
      fatalError()
    }

    return cell
  }
}
#endif
