//
//  AutoPaymentData.swift
//  ARBoost
//
//  Created by Mert Gökçen on 19.08.2021.
//

import Foundation


struct AutoPaymentData: Codable {
    
    var cardNo:String
    var receiver:String
    var amount:Double
    var paymentDay: Int
    var paymentMonth: String
}
