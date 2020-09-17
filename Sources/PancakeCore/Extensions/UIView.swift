//
//  File.swift
//  
//
//  Created by Guilherme Souza on 16/09/20.
//

#if canImport(UIKit)
import UIKit

extension UIView {

    public var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

}
#endif
