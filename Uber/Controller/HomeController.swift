//
//  HomeController.swift
//  Uber
//
//  Created by Mariana Steblii on 10/03/2022.
//

import UIKit

class HomeController: UIViewController {
    // MARK: - Private properties
    
    // MARK: - Public properties
    var firebaseService = FirebaseService()
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        if !firebaseService.checkIfUserLoggedIn() {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            
        }
    }
    
    
}
