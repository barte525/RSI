//
//  AlertFetcher.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 15/06/2022.
//

import Foundation

protocol AlertFetcherProtocol {
    func getAlerts(for userMail: String) async throws -> [AssetAlert]
}

class AlertFetcher: AlertFetcherProtocol, RequestProtocol {
    private let session = URLSession.shared
    private let urlString = "\(K.baseUrl)/api/Alert"
    
    func getAlerts(for userMail: String) async throws -> [AssetAlert] {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let token = try KeychainManager.get(account: userMail, service: K.keychainServiceName)
        let request = createRequest(url: url, token: token, method: "GET")
        let (data, _) = try await session.data(for: request)
        guard let alerts = try? JSONDecoder().decode([AssetAlert].self, from: data) else { throw NetworkError.invalidData }
        return alerts
    }
    
    func postAlert(userMail: String, targetValue: Double, targetValueCurrency: String, alertAssetName: String) async throws -> Bool {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let token = try KeychainManager.get(account: userMail, service: K.keychainServiceName)
        let postBody = ["asset_name": alertAssetName, "currency": targetValueCurrency, "value": targetValue] as [String : Any]
        let request = createRequest(url: url, token: token, method: "POST", body: postBody)
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200:
                guard let isCreated = try? JSONDecoder().decode(Bool.self, from: data) else { throw NetworkError.invalidData }
                return isCreated
            case 401:
                throw UserManagerError.unauthorized
            default:
                throw NetworkError.unknown
            }
        }
        return false
    }
    
    func deleteAlert(for userMail: String, alertId: Int) async throws -> Bool {
        let deletingUrl = "\(urlString)/\(alertId)"
        guard let url = URL(string: deletingUrl) else { throw NetworkError.invalidURL }
        let token = try KeychainManager.get(account: userMail, service: K.keychainServiceName)
        let request = createRequest(url: url, token: token, method: "DELETE")
        let (_, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200:
                return true
            case 401:
                throw UserManagerError.unauthorized
            default:
                throw NetworkError.unknown
            }
        }
        return false
    }
}
