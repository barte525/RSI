//
//  Asset+Mock.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 14/04/2022.
//

import Foundation

extension Asset {
    
    static let pln: Self = .init(id: "1", name: "PLN", type: "Currency")
    static let euro: Self = .init(id: "2", name: "EUR", type: "Currency")
    static let dollar: Self = .init(id: "3", name: "USD", type: "Currency")
    static let bitcoin: Self = .init(id: "4", name: "BTC", type: "Crypto")
    static let gold333: Self = .init(id: "5", name: "ZL333", type: "Metal")
    static let gold900: Self = .init(id: "6", name: "ZL900", type: "Metal")
    static let silver925: Self = .init(id: "7", name: "SR925", type: "Metal")
    
}

extension Asset {
    static let mock: [Self] = [.pln, .euro, .dollar, .bitcoin, .gold333, .gold900, .silver925]
}
