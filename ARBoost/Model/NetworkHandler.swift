//
//  NetworkHandler.swift
//  ARBoost
//
//  Created by Mert Gökçen on 17.08.2021.
//

import Foundation

class NetworkHandler {
    let generalUrl = "https://heroku-spring-backend.herokuapp.com/"
    
    func performRequest() {
        let add = "rest/user/all"
        if let url = URL(string: generalUrl+add){
            let session = URLSession(configuration: .default)
            
           let task = session.dataTask(with: url, completionHandler: handler(data: response: error: ))
        
            task.resume()
        }
        
        func handler(data:Data?,response:URLResponse?,error:Error?){
            if error != nil{
                print(error)
                return
            }
            if let safeData = data {
                print(String(data:safeData, encoding: .utf8))
            }
            
        }
        
    }
}
