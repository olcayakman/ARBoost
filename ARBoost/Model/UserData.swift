//
//  UserData.swift
//  ARBoost
//
//  Created by Mert Gökçen on 17.08.2021.
//

import Foundation

struct UserData: Codable {
    let tckn:String
    let name:String
    let surname:String
    let password:String
    let birthDate: Date?
}
