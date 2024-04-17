//
//  Storyboarded.swift
//  Flags
//
//  Created by Marco Frau on 16/04/24.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        
        let className = NSStringFromClass(self).components(separatedBy: ".").last //Gets view controller name
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let className = className, let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Failed to instantiate a ViewController named: \(String(describing: className))")
        }
        
        return viewController
    }
}
