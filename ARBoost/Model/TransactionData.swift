//
//  TransactionData.swift
//  ARBoost
//
//  Created by Mert Gökçen on 18.08.2021.
//

import Foundation

struct TransactionData: Codable {
    var transactionId:Int
    var cardNo:String
    var sender:String
    var receiver:String
    var amount:Double
   // var type:String
    var transactionDate:String
}
