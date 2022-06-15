//
//  Alert.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 15/06/2022.
//

import Foundation

struct AssetAlert: Decodable {
    let id: Int
    let value: Double
    let currency: String
    let asset_name: String
    let asset_type: String
}
