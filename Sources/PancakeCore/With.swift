//
//  File.swift
//  
//
//  Created by Guilherme Souza on 10/10/20.
//

import Foundation

public func with<T>(_ object: T, transform: (inout T) -> Void) -> T {
  var object = object
  transform(&object)
  return object
}
