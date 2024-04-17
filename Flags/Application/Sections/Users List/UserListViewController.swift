//
//  UserListViewController.swift
//  Flags
//
//  Created by Marco Frau on 15/04/24.
//

import Foundation
import UIKit

class UserListViewController: UIViewController, Storyboarded, UpdateViewProtocol {
    
    var viewModel: UserListViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getUsers()
    }
    
    func updateView() {
        tableView.reloadData()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "UserListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "UserListTableViewCell")
    }
    
    @IBAction func didTapAddUser(_ sender: Any) {
        viewModel?.addUserAction()
    }
}

//MARK: Extension for tableView delegates
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = viewModel?.users[indexPath.row] else { return UITableViewCell() }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as? UserListTableViewCell {
            cell.configure(user: user)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UserListTableViewCell {
            guard let userId = cell.getUserId() else { return }
            viewModel?.showUser(userId: userId)
        }
    }
}
