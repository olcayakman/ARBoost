//
//  DebitCard.swift
//  ARBoost
//
//  Created by Mert Gökçen on 18.08.2021.
//

import Foundation

class DebitCard {
    var tckn : String
    var cardNo : String
    var expMonth : String
    var expYear : String
    var cvv : String
    var balance : Double
    var wordPoint : Double
    var contactless : Bool
    var ecom : Bool
    var mailOrder : Bool
    
    init(tckn : String, cardNo : String, expMonth : String, expYear : String, cvv :String , balance : Double
        ,wordPoint : Double, contactless : Bool, ecom : Bool, mailOrder : Bool) {
        self.tckn = tckn
        self.cardNo = cardNo
        self.expMonth = expMonth
        self.expYear = expYear
        self.cvv = cvv
        self.balance = balance
        self.wordPoint = wordPoint
        self.contactless = contactless
        self.ecom = ecom
        self.mailOrder = mailOrder
        
    }
    
    
}
