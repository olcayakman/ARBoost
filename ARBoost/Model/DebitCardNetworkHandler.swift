//
//  DebitCardNetworkHandler.swift
//  ARBoost
//
//  Created by Mert Gökçen on 18.08.2021.
//

import Foundation

class DebitCardNetworkHandler {
    let generalUrl = "https://heroku-spring-backend.herokuapp.com/debit_card/"
    
    func decodeDate(d:String)throws ->Date{
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = iso8601DateFormatter.date(from: d)
        return date!
    }
    
    func getByCardNo(cardNo:String) -> DebitCard? {
        var toReturn:DebitCard? = nil
        let semaphore = DispatchSemaphore(value: 0)
    
        if let url = URL(string: generalUrl+"card_no="+cardNo){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print("Error in task")
                    print(error)
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    do{
                        print(safeData)
                        let decodedData = try decoder.decode(DebitCardData.self, from: safeData)
                        print(decodedData)
                        
                        let tckn = decodedData.tckn
                        let cardNo = decodedData.cardNo
                        let expMonth = decodedData.expMonth
                        let expYear = decodedData.expYear
                        let cvv = decodedData.cvv
                        let balance = decodedData.balance
                        let wordPoint = decodedData.wordPoint
                        let contactless = decodedData.contactless
                        let ecom = decodedData.ecom
                        let mailOrder  = decodedData.mailOrder
                        
                        toReturn = DebitCard(tckn: tckn, cardNo: cardNo, expMonth: expMonth, expYear: expYear, cvv: cvv, balance: balance, wordPoint: wordPoint, contactless: contactless, ecom: ecom, mailOrder: mailOrder)
                        
                    }catch{
                        print(error)
                        print("Error in decoding")
                    }
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
    
    func getByTc(tc:String) -> [String] {
        var toReturn:[String] = []
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
                        let decodedData = try decoder.decode([String].self, from: safeData)
                        toReturn = decodedData
                        
                    }catch{
                        print(error)
                        print("Error in decoding")
                    }
                }
                semaphore.signal()
            }.resume()
            
        }
        else{
            print("Not correct url")
            return []
        }
        semaphore.wait()
        return toReturn
    }
}
