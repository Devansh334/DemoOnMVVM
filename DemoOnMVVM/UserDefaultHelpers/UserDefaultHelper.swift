//
// UserDefaultHelper.swift
// DemoOnMVVM
//



import UIKit
import Foundation

class UserDefaultHelper {
    
    public static let shared = UserDefaultHelper()
    
    private init() {}
    
    var userId: Int {
        get { return UserDefaults.standard.integer(forKey: "userId") }
        set { UserDefaults.standard.set(newValue, forKey: "userId") }
    }
    
    func resetKeys() {
        UserDefaults.standard.removeObject(forKey: "userId")
    }
}
