//
//  TransactionNetworkHandler.swift
//  ARBoost
//
//  Created by Mert Gökçen on 18.08.2021.
//

import Foundation


class TransactionNetworkHandler {
    let generalUrl = "https://heroku-spring-backend.herokuapp.com/transaction/"
    
    func getByCardNo(cardNo:String) -> [Transaction] {
        var toReturn:[Transaction] = []
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
                    do{
                        let decodedData = try decoder.decode([TransactionData].self, from: safeData)
                        print(decodedData)
                        for decoded in decodedData{
                            let id = decoded.transactionId
                            let cardNo = decoded.cardNo
                            let sender = decoded.sender
                            let reciever = decoded.receiver
                            let amount = decoded.amount
                            let type = decoded.type
                            var date = decoded.transactionDate
                            let end = date.firstIndex(of: "T") ?? date.endIndex
                            
                            date = String(date[..<end])
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let Day = dateFormatter.date(from: date)
                            
                            toReturn.append(Transaction(id: id, cardNo: cardNo, sender: sender, reciever: reciever, amount: amount, type: type, date: Day!))
                        }
                    
                        
                    }catch{
                        print(error)
                        print("Error in decoding")
                        semaphore.signal()
                    }
                    //print(String(data:safeData, encoding: .utf8))
                    
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
