//
//  User+Mock.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 19/04/2022.
//

import Foundation

struct UserMock {
    
    static let user1: User = User(id: "123435", email: "john.smith@gmail.com", name: "John", surname: "Smith", currencyPreference: "EUR")
    static let user2: User = User(id: "435325", email: "angela.rock@gmail.com", name: "Angela", surname: "Rock", currencyPreference: "EUR")
    static let user3: User = User(id: "352325", email: "h.jack@gmail.com", name: "Harry", surname: "Jack", currencyPreference: "USD")
    static let user4: User = User(id: "796595", email: "peter.smith@gmail.com", name: "Peter", surname: "Smith", currencyPreference: "PLN")
    static let user5: User = User(id: "358315", email: "m.g@gmail.com", name: "Michael", surname: "Godwin", currencyPreference: "EUR")
    
}
