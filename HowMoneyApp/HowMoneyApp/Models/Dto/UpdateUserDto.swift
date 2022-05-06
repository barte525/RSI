//
//  UpdateUserDto.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 07/05/2022.
//

import Foundation

struct UpdateUserDto: Decodable {
    let id: String
    let email: String
    let name: String
    let surname: String
    let currencyPreference: String
}
