//
//  Transaction.swift
//  ARBoost
//
//  Created by Mert Gökçen on 18.08.2021.
//

import Foundation

class Transaction {
    var id:Int
    var cardNo:String
    var sender:String
    var reciever:String
    var amount:Double
    var type:String
    var date:Date?
    
    init(id:Int,cardNo:String,sender:String,reciever:String,
         amount:Double,type:String,date:Date){
        self.id = id
        self.cardNo = cardNo
        self.sender = sender
        self.reciever = reciever
        self.amount = amount
        self.type = type
        self.date = date
    }
}
