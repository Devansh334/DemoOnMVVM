//
// NetworkController.swift
// DemoOnMVVM
//



import UIKit

class NetworkController {
    
    public static let shared = NetworkController()
    private init() {}
    
    //MARK: API Call for Creating a User or Sign up
    
    func createUser (user: User , success : @escaping ()->Void , faliure : @escaping (String)->Void)  {
        
        guard let url = URL(string : EndpointURL.signUpURL) else { return }
        
        var request  = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        }
        catch {
            faliure("Failed to Encode data in Json")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) {data ,response , error in
            
            if let error = error {
                faliure(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                faliure("No response data")
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let status = jsonResponse["status"] as? String,
                   let message = jsonResponse["message"] as? String {
                    
                    if status == "success" {
                        success()
                    } else {
                        faliure(message)
                    }
                    
                } else {
                    faliure("Invalid response format")
                }
            } catch {
                faliure("Failed to parse JSON: \(error.localizedDescription)")
            }
            
        }
        
        task.resume()
    }
    
    //MARK: API Call for authenticate a User or Log in
    
    func authenticateUser(
        _ email : String ,
        _ password : String ,
        success : @escaping (UserAuthenticationModel)->Void,
        failure : @escaping (String)->Void
    ) {
        
        guard let url = URL(string: EndpointURL.signInURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameter : [String : Any] = [
            "email" : email ,
            "password" : password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter ,
                                                       options: [])
        
        let task = URLSession.shared.dataTask(with: request) {
            data , response , error in
            
            if let error = error {
                failure(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let dataResponse = try JSONDecoder().decode(UserAuthenticationModel.self ,from: data)
                success(dataResponse)
                
            }
            catch {
                failure("Failed to Decode the data")
            }
        }
        
        task.resume()
    }
    
    //MARK: API Call for fetching user details by user ID
    
    func fetchUserByID(
        sucess : @escaping (UserDetailsModel)->Void ,
        failure : @escaping (String)->Void
    ) {
        let endPoint = EndpointURL.getUserURL + String(
            UserDefaultHelper.shared.userId
        )
        guard let url = URL(string: endPoint) else{ return }
        
        let task = URLSession.shared.dataTask(with: url) {data ,response ,error in
            
            if let error = error {
                failure(error.localizedDescription)
                return
            }
            guard let data = data else {
                failure("No User Found")
                return
            }
            do {
                let model = try JSONDecoder().decode(UserDetailsModel.self,from: data)
                sucess(model)
            }
            catch {
                failure("Error in decoding data")
            }
        }
        task.resume()
    }
    
    
}

