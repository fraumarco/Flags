//
//  User+CoreDataProperties.swift
//  Flags
//
//  Created by Marco Frau on 15/04/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?

}

extension User : Identifiable {

}
