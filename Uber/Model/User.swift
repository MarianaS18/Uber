//
//  User.swift
//  Uber
//
//  Created by Mariana Steblii on 12/03/2022.
//

import Foundation
import CoreLocation

enum AccountType: Int {
    case passanger // 0
    case driver // 1
}

struct User {
    let username: String
    let email: String
    var accountType: AccountType!
    var location: CLLocation?
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        
        if let index = dictionary["accountType"] as? Int {
            self.accountType = AccountType(rawValue: index)!
        }
    }
}
