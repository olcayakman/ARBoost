//
//  Account.swift
//  ARBoost
//
//  Created by Mert Gökçen on 19.08.2021.
//

import Foundation



class Account {
    
    var tckn:String
    var cardNo:String
    var iban:String = ""
    var balance:Double
    var accountType:String
    
    init(tckn:String,cardNo:String,iban2:String,balance:Double,accountType:String){
        
        self.tckn = tckn
        self.cardNo = cardNo
        self.balance = balance
        self.accountType = accountType
        
        turnToActual(iban: iban2)
    }
    
    func turnToActual(iban:String) {
        let arr = Array(iban)
        self.iban = String(arr[0..<4])+" "+String(arr[4..<8])+" "+String(arr[8..<12])+" "+String(arr[12..<16])
        + " "+String(arr[16..<20])+" "+String(arr[20..<24])+" "+String(arr[24..<26])
    }
    
}
