//
//  Asset.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 13/04/2022.
//

import Foundation

struct Asset: Hashable, Decodable {
    let id: String
    let name: String
    let type: String
}
