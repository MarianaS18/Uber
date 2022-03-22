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
    private let locationManager = LocationHandler.shared.locationManager
    private let locationInputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    private let tableView = UITableView()
    
    private let locationInputViewHeight: CGFloat = 200
    
    private var user: User? {
        didSet {
            locationInputView.user = user
        }
    }
    
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // FirebaseService.shared.signOut()
        setupUI()
        fetchUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkUser()
        enableLocationServices()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        // hide navigation bar
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func checkUser() {
        if !FirebaseService.shared.checkIfUserLoggedIn() {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            setupMapView()
            fetchDrivers()
        }
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        // show user location
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        setupConstraints()
        
        mapView.delegate = self
    }
    
    private func setupConstraints() {
        view.addSubview(locationInputActivationView)
        locationInputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 40, paddingLeft: 32, paddingRight: 32, height: 50)
        locationInputActivationView.alpha = 0
        locationInputActivationView.delegate = self
        
        UIView.animate(withDuration: 1) {
            self.locationInputActivationView.alpha = 1
        }
    }
    
    private func setupLocationInputView() {
        locationInputView.delegate = self
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: locationInputViewHeight)
        locationInputView.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.locationInputView.alpha = 1
        }) { _ in
            // show table view with animation
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            })
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: Constants.locationCellId)
        tableView.rowHeight = 60
        
        let tableViewHeight = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: tableViewHeight)
        
        view.addSubview(tableView)
    }
    
    private func fetchUserData() {
        FirebaseService.shared.fetchUserData { user in
            self.user = user
        }
    }
    
    private func fetchDrivers() {
        guard let location = locationManager?.location else { return }
        FirebaseService.shared.fetchDrivers(location: location) { driver in
            guard let coordinate = driver.location?.coordinate else { return }
            let annotation = DriverAnnotation(uid: driver.email, coordinate: coordinate)
            
            var driverIsVisible: Bool {
                return self.mapView.annotations.contains(where: { annotation -> Bool in
                    guard let driverAnnotation = annotation as? DriverAnnotation else { return false }
                    if driverAnnotation.uid == driver.email {
                        // update position
                        driverAnnotation.updateAnnotationPosition(withCoordinate: coordinate)
                        return true
                    }
                    return false
                })
            }
            
            if !driverIsVisible {
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
}

// MARK: - LocationServices
extension HomeController {
    
   private func enableLocationServices() {
        switch CLLocationManager().authorizationStatus {
        case .notDetermined:
            print("DEBUG: not determined")
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("DEBUG: authorized always")
            locationManager?.startUpdatingLocation()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("DEBUG: authorized when in use")
            locationManager?.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
}

// MARK: - LocationInputActivationViewDelegate
extension HomeController: LocationInputActivationViewDelegate {
    
    func presentLocationInputView() {
        locationInputActivationView.alpha = 0
        setupLocationInputView()
        setupTableView()
    }
    
}

// MARK: - LocationInputViewDelegate
extension HomeController: LocationInputViewDelegate {
    
    func dismissLocationInputView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.locationInputView.alpha = 0
            self.tableView.frame.origin.y = self.view.frame.height
        }) { _ in
            self.locationInputView.removeFromSuperview()
            UIView.animate(withDuration: 0.3) {
                self.locationInputActivationView.alpha = 1
            }
        }
    }
    
}

// MARK: - UITableViewDelegate/DataSource
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Test"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2: 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.locationCellId, for: indexPath) as! LocationCell
        return cell
    }
    
}

// MARK: - MKMapViewDelegate
extension HomeController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DriverAnnotation {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationId)
            view.image = UIImage(systemName: "arrow.right.circle.fill")
            return view
        }
        return nil
    }
    
}
