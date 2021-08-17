//
//  CreditCard.swift
//  ARBoost
//
//  Created by Mert Gökçen on 17.08.2021.
//

import Foundation

class CreditCard {
    var tckn : String
    var cardNo : String
    var expMonth : String
    var expYear : String
    var cvv : String
    var cardLimit : Double
    var debt : Double
    var cutOffDate : Date
    var paymentDueDate : Date
    var wordPoint : Double
    var contactless : Bool
    var ecom : Bool
    var mailOrder : Bool
    
    init(tckn : String, cardNo : String, expMonth : String, expYear : String, cvv :String , cardLimit : Double, debt : Double, cutOffDate : Date, paymentDueDate : Date
        , wordPoint : Double, contactless : Bool, ecom : Bool, mailOrder : Bool) {
        self.tckn = tckn
        self.cardNo = cardNo
        self.expMonth = expMonth
        self.expYear = expYear
        self.cvv = cvv
        self.cardLimit = cardLimit
        self.debt = debt
        self.cutOffDate = cutOffDate
        self.paymentDueDate = paymentDueDate
        self.wordPoint = wordPoint
        self.contactless = contactless
        self.ecom = ecom
        self.mailOrder = mailOrder
        
    }
    
    
}
