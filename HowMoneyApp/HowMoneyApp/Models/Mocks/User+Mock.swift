//
//  User+Mock.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 19/04/2022.
//

import Foundation

struct UserMock {
    
    static let user1: User = User(id: "123435", email: "john.smith@gmail.com", name: "John", surname: "Smith", sum: 0.0, currencyPreference: "EUR")
    static let user2: User = User(id: "435325", email: "angela.rock@gmail.com", name: "Angela", surname: "Rock", sum: 90.4, currencyPreference: "EUR")
    static let user3: User = User(id: "352325", email: "h.jack@gmail.com", name: "Harry", surname: "Jack", sum: 123.56, currencyPreference: "USD")
    static let user4: User = User(id: "796595", email: "peter.smith@gmail.com", name: "Peter", surname: "Smith", sum: 198.4, currencyPreference: "PLN")
    static let user5: User = User(id: "358315", email: "m.g@gmail.com", name: "Michael", surname: "Godwin", sum: 14.78, currencyPreference: "EUR")
    
}
