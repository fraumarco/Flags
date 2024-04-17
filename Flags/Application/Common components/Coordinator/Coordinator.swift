//
//  Coordinator.swift
//  Flags
//
//  Created by Marco Frau on 15/04/24.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var childCoordinators: [Coordinator] { get set }

    
    var navigationController: UINavigationController { get set }
    
    func start()
}

extension Coordinator {
    mutating func finish() {
        childCoordinators.removeAll()
    }
}
