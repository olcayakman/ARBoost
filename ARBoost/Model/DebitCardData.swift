//
//  DebitCardData.swift
//  ARBoost
//
//  Created by Mert Gökçen on 18.08.2021.
//

import Foundation

struct DebitCardData : Codable {
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
}
