//
//  NetworkError.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 15/04/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case noConnection
    case unknown
}
