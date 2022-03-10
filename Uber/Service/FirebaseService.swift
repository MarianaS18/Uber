//
//  FirebaseService.swift
//  Uber
//
//  Created by Mariana Steblii on 10/03/2022.
//

import UIKit
import Firebase

class FirebaseService {
    
    let db = Firestore.firestore()
    
    func signIn(email: String, username: String, password: String, accountTypeIndex: Int) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register user with error \(error.localizedDescription)")
                return
            }
            else {
                // add user to a collection of users
                self.createUser(email, username, accountTypeIndex)
            }
        }
    }
    
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBAG: Failed to log user in with error \(error.localizedDescription)")
                return
            }
            else {
                print("Succesfully logged user in")
            }
        }
    }
    
    private func createUser(_ email: String, _ username: String, _ accountTypeIndex: Int) {
        self.db.collection("users").addDocument(data: [
            "username": username,
            "email": email,
            "accountType": accountTypeIndex])
        { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added")
                }
        }
    }
}
