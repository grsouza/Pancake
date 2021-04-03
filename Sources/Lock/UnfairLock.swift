//
//  File.swift
//  
//
//  Created by Guilherme Souza on 03/04/21.
//

import Foundation

@available(OSX 10.12, *)
final class UnfairLock: LockProtocol {

  // MARK: Lifecycle

  init() {
    _lock = .allocate(capacity: 1)
    _lock.initialize(to: os_unfair_lock())
  }

  deinit {
    _lock.deinitialize(count: 1)
    _lock.deallocate()
  }

  // MARK: Internal

  func lock() {
    os_unfair_lock_lock(_lock)
  }

  func unlock() {
    os_unfair_lock_unlock(_lock)
  }

  func `try`() -> Bool {
    os_unfair_lock_trylock(_lock)
  }

  // MARK: Private

  private let _lock: os_unfair_lock_t

}
