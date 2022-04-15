//
//  UserAsset.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 10/04/2022.
//

import Foundation

struct UserAsset: Identifiable {
    let id: Int
    let asset: Asset
    let assetAmount: Double
}
