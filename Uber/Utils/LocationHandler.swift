//
//  LocationHandler.swift
//  Uber
//
//  Created by Mariana Steblii on 21/03/2022.
//

import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate {
    static let shared = LocationHandler()
    var locationManager: CLLocationManager!
    var location: CLLocation?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    
    // if user chooses to allow location when using app, new message shows up immediately
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}
