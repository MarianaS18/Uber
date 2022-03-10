//
//  UIView extensions.swift
//  Uber
//
//  Created by Mariana Steblii on 09/03/2022.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func createContainerView(image: UIImage, textField: UITextField? = nil, segmentedControl: UISegmentedControl? = nil) -> UIView {
        let containerView = UIView()
    
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87
        containerView.addSubview(imageView)
        imageView.centerY(inView: containerView)
        imageView.anchor(left: containerView.leftAnchor, paddingLeft: 8, width: 24, height: 24)
        
        if let textField = textField {
            containerView.addSubview(textField)
            textField.centerY(inView: imageView)
            textField.anchor(left: imageView.rightAnchor, paddingLeft: 12)
        }
        
        if let segmentedControl = segmentedControl {
            containerView.addSubview(segmentedControl)
            segmentedControl.anchor(left: imageView.rightAnchor, bottom: imageView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8)
        }
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        containerView.addSubview(separatorView)
        separatorView.anchor(top: containerView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        return containerView
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
    }
}
