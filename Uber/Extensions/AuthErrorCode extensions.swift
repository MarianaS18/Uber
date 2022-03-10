//
//  AuthErrorCode extensions.swift
//  Uber
//
//  Created by Mariana Steblii on 10/03/2022.
//

import UIKit
import FirebaseAuth

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        
        // register errors
        case .emailAlreadyInUse:
            return "The email is already in use"
        case .invalidEmail, .invalidSender, .invalidRecipientEmail, .missingEmail:
            return "Please enter a valid email"
        case .weakPassword:
            return "Your password is too weak"
        
        // login errors
        case .wrongPassword:
            return "Password is wrong"
        case .userNotFound:
            return "User account was not found"
        
        // general errors
        case .networkError:
            return "Network error. Please try again."
        default:
            return "Unknown error occurred"
        }
    }
}

