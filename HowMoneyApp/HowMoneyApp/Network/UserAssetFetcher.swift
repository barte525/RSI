//
//  UserAssetFetcher.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 27/04/2022.
//

import Foundation

protocol UserAssetFetcherProtocol {
    func getAssets(for userMail: String) async throws -> [UserAsset]
}

class UserAssetFetcher: UserAssetFetcherProtocol, RequestProtocol {
    private let session = URLSession.shared
    private let urlString = "\(K.baseUrl)/api/UserAsset"
    
    func getAssets(for userMail: String) async throws -> [UserAsset] {
        let token = try KeychainManager.get(account: userMail, service: K.keychainServiceName)
        print(token)
        
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let request = createRequest(url: url, method: "GET")
        let (data, _) = try await session.data(for: request)
        guard let assets = try? JSONDecoder().decode([UserAsset].self, from: data) else { throw NetworkError.invalidData }
        return assets
    }
}
