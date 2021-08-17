//
//  CreditCardNetworkHandler.swift
//  ARBoost
//
//  Created by Mert Gökçen on 17.08.2021.
//

import Foundation

class CreditCardNetworkHandler {
    let generalUrl = "https://heroku-spring-backend.herokuapp.com/rest/credit_card/"
    
    func decodeDate(d:String)throws ->Date{
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = iso8601DateFormatter.date(from: d)
        return date!
    }
    
    func getByCardNo(cardNo:String) -> CreditCard? {
        var toReturn:CreditCard? = nil
        let semaphore = DispatchSemaphore(value: 0)
    
        if let url = URL(string: generalUrl+cardNo){
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
                        let decodedData = try decoder.decode(CreditCardData.self, from: safeData)
                        print(decodedData)
                        let tckn = decodedData.tckn
                        let cardNo = decodedData.cardNo
                        let expMonth = decodedData.expMonth
                        let expYear = decodedData.expYear
                        let cvv = decodedData.cvv
                        let cardLimit = decodedData.cardLimit
                        let debt = decodedData.debt
                        
                        var cutOffDate = decodedData.cutOffDate
                        var end = cutOffDate.firstIndex(of: "T") ?? cutOffDate.endIndex
                        cutOffDate = String(cutOffDate[..<end])
                        
                        var paymentDueDate = decodedData.paymentDueDate
                        end = paymentDueDate.firstIndex(of: "T") ?? paymentDueDate.endIndex
                        paymentDueDate = String(paymentDueDate[..<end])
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let payDay = dateFormatter.date(from: paymentDueDate)
                        let cutOffDay = dateFormatter.date(from: cutOffDate)
                        
                        
                        let wordPoint = decodedData.wordPoint
                        let contactless = decodedData.contactless
                        let ecom = decodedData.ecom
                        let mailOrder  = decodedData.mailOrder
                        
                        toReturn = CreditCard(tckn: tckn, cardNo: cardNo, expMonth: expMonth, expYear: expYear, cvv: cvv, cardLimit: cardLimit, debt: debt, cutOffDate: cutOffDay!, paymentDueDate: payDay!, wordPoint: wordPoint, contactless: contactless, ecom: ecom, mailOrder: mailOrder)
                        
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
    
        if let url = URL(string: generalUrl+"tc/"+tc){
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
