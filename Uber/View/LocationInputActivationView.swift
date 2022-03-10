//
//  LocationInputActivationView.swift
//  Uber
//
//  Created by Mariana Steblii on 10/03/2022.
//

import UIKit

protocol LocationInputActivationViewDelegate: AnyObject {
    func presentLocationInputView()
}

class LocationInputActivationView: UIView {
    // MARK: - Private properties
    private let indicatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private let placeholderLabel: UILabel = {
        let label = UILabel().createLabel(withText: "Where to?", font: UIFont.systemFont(ofSize: 18))
        label.textColor = .darkGray
        return label
    }()
    
    // MARK: - Public properties
    weak var delegate: LocationInputActivationViewDelegate?
    
    // MARK: - View Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func setupUI() {
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
        
        addSubview(indicatorView)
        indicatorView.anchor(left: self.leftAnchor, paddingLeft: 16, width: 5, height: 5)
        indicatorView.centerY(inView: self)

        addSubview(placeholderLabel)
        placeholderLabel.anchor(left: indicatorView.rightAnchor, paddingLeft: 16)
        placeholderLabel.centerY(inView: self)
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentLocationInputView))
        addGestureRecognizer(tap)
    }
    
    // MARK: - objc functions
    @objc private func presentLocationInputView() {
        delegate?.presentLocationInputView()
    }
}
