//
// User.swift
// DemoOnMVVM
//



import Foundation

struct User : Codable {
    
    var userName : String?
    var userAge : Int?
    var userEmail : String?
    var userPassword : String?
    
    init(
        userName: String? = nil,
        userAge: Int? = nil,
        userEmail: String? = nil,
        userPassword: String? = nil
    ) {
        self.userName = userName
        self.userAge = userAge
        self.userEmail = userEmail
        self.userPassword = userPassword
    }
 }
