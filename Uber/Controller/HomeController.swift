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
            setupMapKit()
        }
    }
    
    private func setupMapKit() {
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
}
