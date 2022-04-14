//
//  Asset+Mock.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 14/04/2022.
//

import Foundation

extension Asset {
    
    static let pln: Self = .init(name: "PLN", type: "Currency")
    static let euro: Self = .init(name: "EUR", type: "Currency")
    static let dollar: Self = .init(name: "USD", type: "Currency")
    static let bitcoin: Self = .init(name: "BTC", type: "Crypto")
    static let gold333: Self = .init(name: "ZL333", type: "Metal")
    static let gold900: Self = .init(name: "ZL900", type: "Metal")
    static let silver925: Self = .init(name: "SR925", type: "Metal")
    
}

extension Asset {
    static let mock: [Self] = [.pln, .euro, .dollar, .bitcoin, .gold333, .gold900, .silver925]
}
