//
//  UserAsset.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 10/04/2022.
//

import Foundation

struct UserAsset: Decodable, Hashable {
    let assetId: String
    let name: String
    let amount: Double
}
