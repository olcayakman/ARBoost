//
//  AutoPaymentNetworkHandler.swift
//  ARBoost
//
//  Created by Mert Gökçen on 19.08.2021.
//

import Foundation


class AutoPaymentNetworkHandler {
    let generalUrl = "https://heroku-spring-backend.herokuapp.com/auto_payment/"
    
    func getNearestByCardNo(cardNo:String) -> AutoPayment? {
        var toReturn:AutoPayment? = nil
        let semaphore = DispatchSemaphore(value: 0)
    
        if let url = URL(string: generalUrl+"/near/card_no="+cardNo){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print("Error in task")
                    print(error)
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode(AutoPaymentData.self, from: safeData)
                        
                        
                        let cardNo = decodedData.cardNo
                        let receiver = decodedData.receiver
                        let amount = decodedData.amount
                        let paymentDay = decodedData.paymentDay
                        let paymentMonth = decodedData.paymentMonth
                        
                        toReturn = AutoPayment(cardNo: cardNo, receiver: receiver, amount: amount, paymentDay: paymentDay, paymentMonth: paymentMonth)
                        
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
