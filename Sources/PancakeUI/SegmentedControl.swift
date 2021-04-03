#if canImport(UIKit)
  import UIKit

  public final class SegmentedControl<Element>: View where Element: Equatable {

    // MARK: Lifecycle

    public init(
      _ items: [Element],
      description: KeyPath<Element, String>,
      initialSelectedItem: Element?,
      onSelect: @escaping (Element) -> Void
    ) {

      self.items = items
      self.onSelect = onSelect
      super.init()

      items
        .enumerated()
        .forEach { index, item in
          segmentedControl.insertSegment(
            withTitle: item[keyPath: description],
            at: index,
            animated: false
          )
        }

      if let indexForInitialSelectedItem = initialSelectedItem.flatMap(items.firstIndex(of:)) {
        segmentedControl.selectedSegmentIndex = indexForInitialSelectedItem
      }

      segmentedControl.addTarget(self, action: #selector(onValueChanged), for: .valueChanged)
    }

    // MARK: Public

    public override func configureSubviews() {
      super.configureSubviews()
      addSubview(segmentedControl)
    }

    public override func configureConstraints() {
      super.configureConstraints()
      segmentedControl.edgesToSuperview()
    }

    public override func additionalConfigurations() {
      super.additionalConfigurations()

    }

    // MARK: Private

    private let segmentedControl = UISegmentedControl(frame: .zero)

    private let items: [Element]
    private let onSelect: (Element) -> Void

    @objc
    private func onValueChanged() {
      let item = items[segmentedControl.selectedSegmentIndex]
      onSelect(item)
    }

  }
#endif
