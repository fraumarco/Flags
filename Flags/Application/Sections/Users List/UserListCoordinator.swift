//
//  UserListCoordinator.swift
//  Flags
//
//  Created by Marco Frau on 15/04/24.
//

import Foundation
import UIKit

class UserListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let vc = UserListViewController.instantiate()
        let viewModel = UserListViewModel(viewProtocol: vc)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAddUserView(shouldShowUser: Bool = false, userId: UUID? = nil) {
        let vc = CreateUserViewController.instantiate()
        let viewModel = CreateUserViewModel()
        viewModel.viewProtocol = vc
        vc.viewModel = viewModel
        
        if shouldShowUser, let userId = userId {
            viewModel.fetchUser(userId: userId)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
}
