//
//  UserAsset+Mock.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 10/04/2022.
//

import Foundation

extension UserAsset {
    
    static let euro: Self = .init(id: 1, asset: Asset(name: "EUR", type: "Currency"), assetAmount: 12.78)
    static let bitcoin: Self = .init(id: 2, asset: Asset(name: "BTC", type: "Crypto"), assetAmount: 0.0000011)
    static let dollar: Self = .init(id: 3, asset: Asset(name: "USD", type: "Currency"), assetAmount: 34.98)
    
}

extension UserAsset {
    static let mock: [Self] = [.euro, .bitcoin, .dollar]
}
