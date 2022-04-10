//
//  UserAsset+Mock.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 10/04/2022.
//

import Foundation

extension UserAsset {
    
    static let euro: Self = .init(id: 1, assetName: "EUR", assetAmount: 12.78)
    static let bitcoin: Self = .init(id: 2, assetName: "BTC", assetAmount: 0.0000011)
    static let dollar: Self = .init(id: 3, assetName: "USD", assetAmount: 34.98)
    
}

extension UserAsset {
    static let mock: [Self] = [.euro, .bitcoin, .dollar]
}
