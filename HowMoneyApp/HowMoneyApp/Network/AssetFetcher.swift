//
//  AssetFetcher.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 15/04/2022.
//

import Foundation


protocol AssetFetcherProtocol {
    func getAll() async throws -> [Asset]
}

class AssetFetcher: AssetFetcherProtocol {
    private let session = URLSession.shared
    private let baseUrl = "\(base)/api/Asset"
    
    func getAll() async throws -> [Asset] {
        guard let url = URL(string: baseUrl) else { throw NetworkError.invalidURL }
        let request = createRequest(url: url, method: "GET")
        let (data, _) = try await session.data(for: request)
        guard let assets = try? JSONDecoder().decode([Asset].self, from: data) else { throw NetworkError.invalidData }
        print(assets)
        return assets
    }
    
    private func createRequest(url: URL, method: String?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
