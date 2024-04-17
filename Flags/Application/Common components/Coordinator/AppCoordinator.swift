//
//  AppCoordinator.swift
//  Flags
//
//  Created by Marco Frau on 15/04/24.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userListCoordinator = UserListCoordinator(navigationController: navigationController)
        userListCoordinator.start()
        childCoordinators.append(userListCoordinator)
    }
    
    
}
