//
//  User.swift
//  ARBoost
//
//  Created by Mert Gökçen on 5.08.2021.
//

import Foundation


class User {
    var tckn:String
    var name:String
    var surname:String
    var password:String
    var birthDate: Date?
    
    init(tckn:String,name:String,surname:String,password:String,birthDate:Date) {
        self.tckn = tckn
        self.name = name
        self.surname = surname
        self.password = password
        self.birthDate = birthDate
    }
    
    init(tckn:String,name:String,surname:String,password:String) {
        self.tckn = tckn
        self.name = name
        self.surname = surname
        self.password = password
        self.birthDate = nil
    }
    
}
