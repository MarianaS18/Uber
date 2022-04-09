//
//  Trip.swift
//  Uber
//
//  Created by Mariana Steblii on 09/04/2022.
//

import CoreLocation

struct Trip {
    var pickupCoordinates: CLLocationCoordinate2D!
    var destinationCoordinates: CLLocationCoordinate2D!
    let passengerId: String!
    var driverId: String?
    var state: TripState!
    
    init(passengerId: String, dictionary: [String: Any]) {
        self.passengerId = passengerId
        
        if let pickupCoordinates = dictionary["pickupCoordinates"] as? NSArray {
            guard let latitude = pickupCoordinates[0] as? CLLocationDegrees else { return }
            guard let longitude = pickupCoordinates[1] as? CLLocationDegrees else { return }
            self.pickupCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        if let destinationCoordinates = dictionary["destinationCoordinates"] as? NSArray {
            guard let latitude = destinationCoordinates[0] as? CLLocationDegrees else { return }
            guard let longitude = destinationCoordinates[1] as? CLLocationDegrees else { return }
            self.destinationCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        self.driverId = dictionary["uid"] as? String ?? ""
        
        if let state = dictionary["state"] as? Int {
            self.state = TripState(rawValue: state)
        }
    }
}

enum TripState: Int {
    case requested // 0
    case accepted // 1
    case inProgress // 2
    case completed // 3
}
