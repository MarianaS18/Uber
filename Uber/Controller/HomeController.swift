//
//  HomeController.swift
//  Uber
//
//  Created by Mariana Steblii on 10/03/2022.
//

import UIKit
import MapKit

class HomeController: UIViewController {
    // MARK: - Private properties
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    // MARK: - Public properties
    var firebaseService = FirebaseService()
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
//        firebaseService.signOut()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkUser()
        enableLocationServices()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        view.backgroundColor = .backgroundColor
    }
    
    private func checkUser() {
        if !firebaseService.checkIfUserLoggedIn() {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            setupMapView()
        }
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        // show user location
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
}

// MARK: - LocationServices
extension HomeController: CLLocationManagerDelegate {
    
   private func enableLocationServices() {
       locationManager.delegate = self
        
        switch CLLocationManager().authorizationStatus {
        case .notDetermined:
            print("DEBUG: not determined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("DEBUG: authorized always")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("DEBUG: authorized when in use")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    // if user chooses to allow location when using app, new message shows up immediately
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
}
