import Foundation

extension Array {
  /// Insert an element at the beginning of array.
  /// - Parameter newElement: Element to insert
  ///
  /// Complexity: O(n), where n is the length of the collection.
  @inlinable
  public mutating func prepend(_ newElement: Element) {
    insert(newElement, at: 0)
  }

  @inlinable
  public mutating func prepend<C>(contentsOf newElements: C)
  where C: Collection, C.Element == Element {
    insert(contentsOf: newElements, at: 0)
  }

}
