//
//  AccountData.swift
//  ARBoost
//
//  Created by Mert Gökçen on 19.08.2021.
//

import Foundation


struct AccountData: Codable {
    var tckn:String
    var cardNo:String
    var iban:String
    var balance:Double
    var accountType:String
}
