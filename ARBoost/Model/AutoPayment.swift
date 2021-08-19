//
//  AutoPayment.swift
//  ARBoost
//
//  Created by Mert Gökçen on 19.08.2021.
//

import Foundation

class AutoPayment {
    
    var cardNo:String
    var receiver:String
    var amount:Double
    var paymentDay: Int
    var paymentMonth: String
    
    init(cardNo:String,receiver:String,amount:Double,paymentDay:Int,paymentMonth:String) {
        
        self.cardNo = cardNo
        self.receiver = receiver
        self.amount = amount
        self.paymentDay = paymentDay
        self.paymentMonth = paymentMonth
        
    }
    
}
