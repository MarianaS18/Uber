//
//  LocationInputView.swift
//  Uber
//
//  Created by Mariana Steblii on 10/03/2022.
//

import UIKit

protocol LocationInputViewDelegate: AnyObject {
    func dismissLocationInputView()
}

class LocationInputView: UIView {

    // MARK: - Private properties
    private let backButton: UIButton = {
        let button = UIButton().createBackButton()
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Public properties
    weak var delegate: LocationInputViewDelegate?
    
    // MARK: - View functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func setupUI() {
        addShadow()
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        addSubview(backButton)
        backButton.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 44, paddingLeft: 16, width: 24, height: 25)
    }
    
    // MARK: - objc functions
    @objc private func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
    
}
