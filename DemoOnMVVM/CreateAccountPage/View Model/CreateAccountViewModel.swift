//
// CreateAccountViewModel.swift
// DemoOnMVVM
//

import Foundation

protocol formValidationHandelProtolcol : AnyObject {
    
    func didContailEmptyField()
    func didEnterInvalidEmail()
    func didEnterInvalidAge()
    func didNotMatchPasswords()
    func didNotAuthError(error : String)
}

class CreateAccountViewModel {
    
    weak var delegate : (formValidationHandelProtolcol)?
    
    func createUser(for model: UserModel, completion: @escaping (Bool) -> Void) {
        
        guard let name = model.name, !name.isEmpty,
              let age = model.age,
              let email = model.email, !email.isEmpty,
              let password = model.password, !password.isEmpty,
              let confirmPassword = model.confirmPassword, !confirmPassword.isEmpty
        else {
            delegate?.didContailEmptyField()
            completion(false)
            return
        }
        guard Utilites.isEmailValid(for: email) else {
            delegate?.didEnterInvalidEmail()
            completion(false)
            return
        }
        if age <= 0 {
            delegate?.didEnterInvalidAge()
            completion(false)
            return
        }
        if password != confirmPassword {
            delegate?.didNotMatchPasswords()
            completion(false)
            return
        }
        
        let user = User(
            userName: model.name,
            userAge: model.age,
            userEmail: model.email,
            userPassword: model.confirmPassword
        )
        
        NetworkController.shared.createUser(user: user, success: {
            print("Auth Success")
            completion(true)
        }, faliure: { [weak self] error in
            print("Error: \(error)")
            DispatchQueue.main.async {
                self?.delegate?.didNotAuthError(error: error)
            }
            completion(false)
        })
    }

}
