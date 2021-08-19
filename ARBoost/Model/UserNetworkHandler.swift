//
//  NetworkHandler.swift
//  ARBoost
//
//  Created by Mert Gökçen on 17.08.2021.
//

import Foundation

class UserNetworkHandler {
    let generalUrl = "https://heroku-spring-backend.herokuapp.com/user/"
    
    func getByTc(tc:String) -> User? {
        var toReturn:User? = nil
        let semaphore = DispatchSemaphore(value: 0)
    
        if let url = URL(string: generalUrl+"tckn="+tc){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print("Error in task")
                    print(error)
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode(UserData.self, from: safeData)
                        let name = decodedData.name
                        let tckn = decodedData.tckn
                        let surname = decodedData.surname
                        let password = decodedData.password
                        let birthDate = decodedData.birthDate
                        toReturn = User(tckn: tckn, name: name, surname: surname, password: password, birthDate: birthDate)
                        
                    }catch{
                        print(error)
                        print("Error in decoding")
                        semaphore.signal()
                    }
                    print(String(data:safeData, encoding: .utf8))
                    
                }
                semaphore.signal()
            }.resume()
            
        }
        else{
            print("Not correct url")
            return nil
        }
        semaphore.wait()
        return toReturn
    }
}
