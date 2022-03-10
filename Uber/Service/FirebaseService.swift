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
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Error signing out")
        }
    }
    
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to log user in with error \(error.localizedDescription)")
                return
            }
            else {
                print("DEBUG: Succesfully logged user in")
            }
        }
    }
    
    func checkIfUserLoggedIn() -> Bool {
        if Auth.auth().currentUser?.uid == nil {
            print("DEBUG: user is not logged in")
            return false
        } else {
            print("DEBUG: user is logged in")
            return true
        }
    }
    
    private func createUser(_ email: String, _ username: String, _ accountTypeIndex: Int) {
        self.db.collection("users").addDocument(data: [
            "username": username,
            "email": email,
            "accountType": accountTypeIndex])
        { error in
                if let error = error {
                    print("DEBUG: Error adding document: \(error)")
                } else {
                    print("DEBUG: Document added")
                }
        }
    }
}
