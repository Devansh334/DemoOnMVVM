//
// LocalizedStrings.swift
// DemoOnMVVM
//

import Foundation

enum LocalizedStrings {
    
    enum LoginScreen {
        static let headerTitle = "🚀 User Sign In !".localized
        static let headerMessage = " Sign in using your account credentials to unlock the benefits of the 🏠 Home screen.✨ You're just a step away! 🔑 Use your username and password to 🔓 sign in.".localized
        enum userEmailField {
            static let title = "* User-Email :".localized
            static let placeholder = "Enter your email".localized
        }
        enum userPassword {
            static let title = "* Password :".localized
            static let placeholder = "Enter your password".localized
        }
        static let loginBtn = "Log In".localized
        static let signUpBtn = "Sign Up".localized
    }
    
    enum SignUpScreen {
        static let headerTitle = "✨ User Sign Up !".localized
        static let headerMessage = "Sign Up by creating your account to unlock the 🏠 Home screen.🚀 You're just a few steps away! After creating the account, use your username and password to 🔓 sign in.".localized
        enum userNameField {
            static let title = "* User-Name :".localized
            static let placeholder = "Enter your Name".localized
        }
        enum userAgeField {
            static let title = "* Age :".localized
            static let placeholder = "Enter your age".localized
        }
        enum userEmailField {
            static let title = "* User-Email :".localized
            static let placeholder = "Enter your email".localized
        }
        enum userPassword {
            static let title = "* Password :".localized
            static let placeholder = "Enter your password".localized
        }
        enum userConfirmPassword {
            static let title = "* Confirm Password :".localized
            static let placeholder = "Enter your confirm password".localized
        }
        static let createAccBtn = "Create Account".localized
        static let goBackBtn = "Back to Login".localized
    }
    
    enum HomeScreen {
        static let headerTitle = "👋 Hey ".localized
        static let headerMessage = "Welcome Home! 🎉 You’re all set. Explore and enjoy your journey with us!.You're now signed in! ✅ Enjoy full access to your account and explore all features.".localized
        static let detailsTableHeader = "User Details".localized
        
        enum User {
            static let name = "User Name : ".localized
            static let email = "User Email : ".localized
            static let age = "User Age : ".localized
        }
        
        static let logOutBtn = "LogOut".localized
    }
    
    enum Alerts {
        static let requiredFieldAlert = "All Fields are required".localized
        static let authFailedAlert = "All fields are required".localized
        static let invalidEmailAlert = "Invalid Email".localized
        static let invalidAgeAlert = "Invalid Age".localized
        static let passwordAlert = "Password and Confirm Password do not match".localized
    }
}

// MARK: - Extention of String to provide NSLocalizedString

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}
