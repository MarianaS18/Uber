//
//  User.swift
//  Uber
//
//  Created by Mariana Steblii on 12/03/2022.
//

import Foundation
import Firebase

struct User {
    let username: String
    let email: String
    let accountType: Int
    
    init(document: QueryDocumentSnapshot) {
        self.username = document.get("username") as? String ?? ""
        self.email = document.get("email") as? String ?? ""
        self.accountType = document.get("accountType") as? Int ?? 0
    }
}
