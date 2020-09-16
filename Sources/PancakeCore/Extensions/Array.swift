//
//  File.swift
//  
//
//  Created by Guilherme Souza on 16/09/20.
//

import Foundation

extension Array {

    /// Insert an element at the beginning of array.
    /// - Parameter newElement: Element to insert
    ///
    /// Complexity: O(n), where n is the length of the collection.
    public mutating func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }
}
