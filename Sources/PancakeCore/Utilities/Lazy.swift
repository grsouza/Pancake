//
//  File.swift
//
//
//  Created by Guilherme Souza on 27/01/21.
//

import Foundation

/// Thread-safe lazily cached methods.
///
/// The `lazy` annotation in Swift does not result in a thread-safe accessor,
/// which can make it an easy source of hard-to-find concurrency races. This
/// class defines a wrapper designed to be used as an alternative for
/// `lazy`. Example usage:
///
/// ```
/// class Foo {
///     var bar: Int { return barCache.value(self) }
///     var barCache = Lazy(someExpensiveMethod)
///
///     func someExpensiveMethod() -> Int { ... }
/// ```
public struct Lazy<Class, Value> {

  // MARK: Lifecycle

  public init(_ body: @escaping (Class) -> () -> Value) {
    self.body = body
  }

  // MARK: Public

  public mutating func value(_ instance: Class) -> Value {
    lock.around {
      if let value = cachedValue {
        return value
      }

      let result = body(instance)()
      cachedValue = result
      return result
    }
  }

  // MARK: Internal

  let body: (Class) -> () -> Value

  var cachedValue: Value?

  // MARK: Private

  private let lock = Lock.make()
}
