//
//  tokenManager.swift
//  music-app
//
//  Created by melina  on 17.10.26.
//
import Foundation


class TokenManager {
    var token : String = ""
    
    var expirationDate : Date?
    
    func fetchToken (completion: @escaping (Error?) -> Void )  {
        
        
        if let expirationDate = expirationDate , !token.isEmpty , Date () < expirationDate {
            completion(nil)
           return

        }
        
        
        let url = URL(string: "https://accounts.spotify.com/api/token")
        var request = URLRequest(url : url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        
        
        let client_id = "0e8de25c190d40a69227bb89a1395e30"
        let client_secret = ""
        
        let bodyData = "grant_type=client_credentials&client_id=\(client_id)&client_secret=\(client_secret)"
        
        request.httpBody = bodyData.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
        
            if let error = error {
               completion(error)
            }
            else{
                let decoder = JSONDecoder()
                if let data = data {
                    
                    do {
                        let decoder = try decoder.decode(TokenData.self, from: data)
                        self.token = decoder.access_token
                        self.expirationDate = Date().addingTimeInterval(TimeInterval (decoder.expires_in))
                       completion(nil)
                    } catch {
                        completion(error)
                    }
                    
                }
            }
            
        }
    
        task.resume()
    }
    
    
}
