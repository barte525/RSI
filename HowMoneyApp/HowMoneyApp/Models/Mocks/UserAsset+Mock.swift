//
//  UserAsset+Mock.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 10/04/2022.
//

import Foundation

struct UserAssetMock {
    
    static let euro: UserAsset = UserAsset(assetId: "1", name: "EUR", amount: 12.78)
    static let bitcoin: UserAsset = UserAsset(assetId: "2", name: "BTC", amount: 0.0000011)
    static let dollar: UserAsset = UserAsset(assetId: "3", name: "USD", amount: 34.98)
    
}

extension UserAssetMock {
    static let mock: [UserAsset] = [euro, bitcoin, dollar]
}
