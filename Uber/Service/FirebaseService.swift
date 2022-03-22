//
//  FirebaseService.swift
//  Uber
//
//  Created by Mariana Steblii on 10/03/2022.
//

import UIKit
import Firebase
import Geofirestore
import CoreLocation
import MapKit

protocol FirebaseServiceDelegate {
    func didPassed()
    func didFailedWithError(error: String)
}

class FirebaseService {
    // MARK: - Singleton
    static let shared = FirebaseService()
    
    // MARK: - Private properties
    private let usersCollection = Firestore.firestore().collection("users")
    private let driverLocationCollection = Firestore.firestore().collection("driver-locations")
    private var location = LocationHandler.shared.locationManager.location
    
    // MARK: - Public properties
    var delegate: FirebaseServiceDelegate?

    // MARK: - Public functions
    func signUp(email: String, username: String, password: String, accountTypeIndex: Int) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    self.delegate?.didFailedWithError(error: errorCode.errorMessage)
                }
            }
            else {
                // add location if driver
                self.createDriverLocation(dokId: email, accountType: accountTypeIndex)
                // add user to a collection of users
                self.createUser(email, username, accountTypeIndex)
                self.delegate?.didPassed()
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
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    self.delegate?.didFailedWithError(error: errorCode.errorMessage)
                }
            }
            else {
                print("DEBUG: Succesfully logged user in")
                self.delegate?.didPassed()
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
    
    func fetchUserData(completion: @escaping(User) -> Void) {
        guard let userEmail = Auth.auth().currentUser?.email else { return }
        
        usersCollection.whereField("email", isEqualTo: userEmail).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("DEBUG: Error getting documents: \(error.localizedDescription)")
            }
            else {
                for document in querySnapshot!.documents {
                    let user = User(document: document)
                    completion(user)
                }
            }
        }
    }
    
    func fetchDrivers(location: CLLocation, completion: @escaping(User) -> Void) {
        // guard let userEmail = Auth.auth().currentUser?.email else { return }
        let geoFirestore = GeoFirestore(collectionRef: driverLocationCollection)
        
        // Query locations at 'location' with a radius of 600 meters
        let query = geoFirestore.query(withCenter: location, radius: 0.6)

        // observe events for a geo query
        _ = query.observe(.documentEntered, with: { (email, location) in
            if let location = location {
                self.fetchUserData { user in
                    var driver = user
                    driver.location = location
                    print("DEBUG: DRIVER: \(driver)")
                    completion(driver)
                }
            }
        })
    }
    
    // MARK: - Private functions
    private func createUser(_ email: String, _ username: String, _ accountTypeIndex: Int) {
        self.usersCollection.addDocument(data: [
            "username": username,
            "email": email.lowercased(),
            "accountType": accountTypeIndex])
        { error in
                if let error = error {
                    print("DEBUG: Error adding document: \(error)")
                } else {
                    print("DEBUG: Document added")
                }
        }
    }
    
    private func createDriverLocation(dokId: String, accountType: Int) {
        let geoFirestore = GeoFirestore(collectionRef: driverLocationCollection)
        
        if accountType == 1 {
            geoFirestore.setLocation(location: location!, forDocumentWithID: dokId) { error in
                if let error = error {
                    print("DEBUG: An error occured: \(error.localizedDescription)")
                } else {
                    print("DEBUG: Saved location successfully!")
                }
            }
        }
    }

}

