//
// UserLoginViewModel.swift
// DemoOnMVVM
//

import Foundation

protocol UserLoginHandleProtocol : AnyObject {
    func didSuccessLogin()
    func didFailedLogin(_ message : String)
    func didNotEnterDetails()
}

class UserLoginViewModel {
    
    weak var delegate : (UserLoginHandleProtocol)?
    var emailFieldText : String?
    var passwordFieldText : String?
    
    func authenticateUser(){
        
        guard let email = emailFieldText, !email.isEmpty,
              let password = passwordFieldText, !password.isEmpty else {
            self.delegate?.didNotEnterDetails()
            return
        }
        
        NetworkController.shared
            .authenticateUser(email, password, success: { [weak self] userAuthModel in
            if(userAuthModel.status == "success") {
                    UserDefaultHelper.shared.userId = userAuthModel.userId ?? 0
                    DispatchQueue.main.async {
                        self?.delegate?.didSuccessLogin()
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self?.delegate?.didFailedLogin(userAuthModel.message ?? "Failed")
                    }
                }
                
            }, failure: { [weak self] errorMessage in
                DispatchQueue.main.async {
                    self?.delegate?.didFailedLogin(errorMessage)
                }
            })
    }
}

