//
// DataController.swift
// DemoOnMVVM
//

import Foundation

// MARK: - OLD LOGIC For Data Storing DO NOT USE IT! USE NetworkController.shared

class DataController {
    
    static let shared = DataController()
    
    private var userName : String?
    private var userAge : Int?
    private var userEmail : String?
    private var userPassword : String?
    
    private init() {}
    
}

// MARK: - Create User 

extension DataController {
    
    func createUser(_ name : String ,_ age : Int ,_ email : String ,_ pass : String) {
        
        self.userName = name
        self.userAge = age
        self.userEmail = email
        self.userPassword = pass
    }
}

// MARK: - Create User Property

extension DataController {
    
    func getUserByProperty(_ userProperty : UserProperties)->String {
        
        switch userProperty {
        case .userName:
            return self.userName ?? ""
        case .userEmail:
            return self.userEmail ?? ""
        case .userAge:
            return String(self.userAge ?? 0)
        case .userPassword:
            return self.userPassword ?? ""
        }
    }
}


