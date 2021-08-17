//
//  CreditCardData.swift
//  ARBoost
//
//  Created by Mert Gökçen on 17.08.2021.
//

import Foundation

struct CreditCardData : Codable {
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
}
