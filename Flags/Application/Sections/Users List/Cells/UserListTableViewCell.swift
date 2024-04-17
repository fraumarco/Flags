//
//  UserListTableViewCell.swift
//  Flags
//
//  Created by Marco Frau on 17/04/24.
//

import Foundation
import UIKit

class UserListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    private var userId: UUID?
    
    func configure(user: User) {
        self.userId = user.id
        if let name = user.name {
            nameLabel.isHidden = false
            nameLabel.text = name
        } else {
            nameLabel.isHidden = true
        }
        
        if let country = user.country {
            countryLabel.isHidden = false
            countryLabel.text = country
        } else {
            countryLabel.isHidden = true
        }
        
        if let phone = user.phone {
            phoneLabel.isHidden = false
            phoneLabel.text = phone
        } else {
            phoneLabel.isHidden = true
        }
        
        if let email = user.email {
            emailLabel.isHidden = false
            emailLabel.text = email
        } else {
            emailLabel.isHidden = true
        }
    }
    
    func getUserId() -> UUID? {
        return userId
    }
}
