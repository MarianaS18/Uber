//
//  User.swift
//  Uber
//
//  Created by Mariana Steblii on 12/03/2022.
//

import Foundation
import Firebase
import CoreLocation

struct User {
    let username: String
    let email: String
    let accountType: Int
    var location: CLLocation?
    
    init(document: QueryDocumentSnapshot) {
        self.username = document.get("username") as? String ?? ""
        self.email = document.get("email") as? String ?? ""
        self.accountType = document.get("accountType") as? Int ?? 0
    }
}
