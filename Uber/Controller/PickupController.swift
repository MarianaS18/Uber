//
//  PickupController.swift
//  Uber
//
//  Created by Mariana Steblii on 16/05/2022.
//

import UIKit
import MapKit

class PickupController: UIViewController {
    // MARK: - Private properties
    private let mapView = MKMapView()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "baseline_clear_white_36pt_2x")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    private let pickupLabel: UILabel = {
        let label = UILabel().createLabel("Would you like to pickup this passenger?", UIFont.systemFont(ofSize: 16), .white)
        return label
    }()
    
    private let acceptTripButton: UIButton = {
        let button = UIButton().createWhiteButton(withText: "ACCEPT TRIP")
        button.addTarget(self, action: #selector(handleAcceptTrip), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Public properties
    let trip: Trip
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
    }
    
    // initialize a controller with a custom object
    init(trip: Trip) {
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private functions
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 8, paddingLeft: 16)
        
        view.addSubview(mapView)
        mapView.anchor(width: 270, height: 270)
        mapView.layer.cornerRadius = 270 / 2
        mapView.centerX(inView: view)
        mapView.centerY(inView: view, constant: -view.frame.height/4)
        
        view.addSubview(pickupLabel)
        pickupLabel.anchor(top: mapView.bottomAnchor, paddingTop: 16)
        pickupLabel.centerX(inView: view)
        
        view.addSubview(acceptTripButton)
        acceptTripButton.anchor(top: pickupLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingRight: 32)
    }
    
    private func setupMapView() {
        let region = MKCoordinateRegion(center: trip.pickupCoordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: false)
        
        let annotaion = MKPointAnnotation()
        annotaion.coordinate = trip.pickupCoordinates
        mapView.addAnnotation(annotaion)
        mapView.selectAnnotation(annotaion, animated: true)
    }
    
    // MARK: - Private @objc functions
    @objc private func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleAcceptTrip() {
       
    }
}
