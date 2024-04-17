//
//  UserListViewModel.swift
//  Flags
//
//  Created by Marco Frau on 15/04/24.
//

import Foundation

class UserListViewModel {
    
    var viewProtocol: UpdateViewProtocol
    var coordinator: UserListCoordinator?
    
    var users: [User] = []
    
    init(viewProtocol: UpdateViewProtocol) {
        self.viewProtocol = viewProtocol
    }
    
    func getUsers() {
        do {
            self.users = try CoreDataManager.shared.viewContext.fetch(User.fetchRequest())
            viewProtocol.updateView()
        }
        catch {
            print("Error fetching data")
        }
    }
    
    func showUser(userId: UUID) {
        coordinator?.showAddUserView(shouldShowUser: true, userId: userId)
    }
    
    func addUserAction() {
        print("Tapped add user")
        coordinator?.showAddUserView()
    }
}
