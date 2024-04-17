//
//  String+EXT.swift
//  Flags
//
//  Created by Marco Frau on 17/04/24.
//

import Foundation

extension String {
    
    var isValidName: Bool {
        return self.isEmpty == false
    }
    
    var isValidCountry: Bool {
        return self != "-" && !self.isEmpty
    }
    
    var isValidPhoneNumber: Bool {
        return NSPredicate(format: "SELF MATCHES %@", #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#).evaluate(with: self)
    }
    
    var isValidEmail: Bool {
            return NSPredicate(
                format: "SELF MATCHES %@", "([a-z]){1,}[@]{1}([a-z]){1,}[.]{1}[a-z]{2,}$"
            )
            .evaluate(with: self)
        }
}
