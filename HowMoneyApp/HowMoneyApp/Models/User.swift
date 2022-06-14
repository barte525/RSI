//
//  User.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 19/04/2022.
//

import Foundation

struct User: Decodable {
    let id: String
    let email: String
    let name: String
    let surname: String
    let currencyPreference: String
}
