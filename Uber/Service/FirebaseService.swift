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
    private let tripsCollection = Firestore.firestore().collection("trips")

    private var location = LocationHandler.shared.locationManager.location
    
    // MARK: - Public properties
    var delegate: FirebaseServiceDelegate?
    let currentEmail = Auth.auth().currentUser?.email

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
    
    func fetchUserData(email: String, completion: @escaping(User) -> Void) {
        usersCollection.whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
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
    
    func fetchDrivers(currentLocation: CLLocation, completion: @escaping(User) -> Void) {
        let geoFirestore = GeoFirestore(collectionRef: driverLocationCollection)
        
        // Query locations at 'location' with a radius of 20 000 meters (20 km)
        let query = geoFirestore.query(withCenter: currentLocation, radius: 20.0)

        // observe events for a geo query
        _ = query.observe(.documentEntered, with: { (email, location) in
            if let email = email, let location = location {
                // check if the distance from current user's location is less then 20000 m (20 km) (!radius doesn't work for it!)
                if location.distance(from: currentLocation) < 20000 {
                    self.fetchUserData(email: email, completion: { user in
                        var driver = user
                        driver.location = location
                        completion(driver)
                    })
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

    func uploadTrip(_ pickupCoordinates: CLLocationCoordinate2D, _ destinationCoordinates: CLLocationCoordinate2D, completion: @escaping(Error?) -> Void) {
        guard let email = Auth.auth().currentUser?.email  else { return }
        
        // create an array out of pickup coordinates and destination coordinates
        let pickupArray = [pickupCoordinates.latitude, pickupCoordinates.longitude]
        let destinationArray = [destinationCoordinates.latitude, destinationCoordinates.longitude]
        
        // create a dictionary that we want to upload
        let values = ["uid": email, "pickupCoordinates": pickupArray, "destinationCoordinates": destinationArray] as [String : Any]
        
        tripsCollection.addDocument(data: values, completion: completion)
    }
}

