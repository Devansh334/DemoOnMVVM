//
// HomeViewModel.swift
// DemoOnMVVM
//

import Foundation

protocol FetchUserDataHandleProtocol : AnyObject {
    func didFetchedUser(_ user : UserDetailsModel)
    func didGetError(_ message : String)
}

class HomeViewModel {
    
    weak var delegate : (FetchUserDataHandleProtocol)?
    
    func fetchUserData() {
        
        NetworkController.shared.fetchUserByID { [weak self] DataModel in
            DispatchQueue.main.async {
                self?.delegate?.didFetchedUser(DataModel)
            }
        } failure: { [weak self] message in
            DispatchQueue.main.async {
                self?.delegate?.didGetError(message)
            }
        }
    }
    
}
