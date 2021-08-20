//
//  AccountNetworkHandler.swift
//  ARBoost
//
//  Created by Mert Gökçen on 19.08.2021.
//

import Foundation


class AccountNetworkHandler {
    let generalUrl = "https://heroku-spring-backend.herokuapp.com/account/"
    
    func getaccountByTC(tc:String) -> Account? {
        var toReturn:Account? = nil
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
                        let decodedData = try decoder.decode(AccountData.self, from: safeData)
                        
                        
                        
                        let cardNo = decodedData.cardNo
                        let tckn = decodedData.tckn
                        let iban = decodedData.iban
                        let balance = decodedData.balance
                        let accountType = decodedData.accountType
                        
                        toReturn = Account(tckn: tckn, cardNo: cardNo, iban2: iban, balance: balance, accountType: accountType)
                        
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
