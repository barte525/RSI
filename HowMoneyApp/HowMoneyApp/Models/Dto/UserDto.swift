//
//  UserDto.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 27/04/2022.
//

import Foundation

struct UserDto: Decodable {
    let id: String
    let email: String
    let name: String
    let surname: String
    let currencyPreference: String
    let token: String
}
