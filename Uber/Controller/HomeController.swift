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
    private let locationInputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    private let tableView = UITableView()
    
    private let locationInputViewHeight: CGFloat = 200
    
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
        
        // hide navigation bar
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
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
        
        setupConstraints()
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
