//
//  AssetViewModel.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 15/04/2022.
//

import Foundation

@MainActor
class AssetsListViewModel: ObservableObject {
    
    private let assetFetcher: AssetFetcher
    private var task: Task<(), Never>?
    private var assets: [Asset] = []
    
    @Published var assetsByType: [String: [Asset]] = [:]
    @Published var isLoading: Bool = false
    
    init(fetcher: AssetFetcher) {
        self.assetFetcher = fetcher
    }
    
    func getAllAssets() {
        task = Task {
            isLoading = true
            do {
                assets = try await assetFetcher.getAll()
                assetsByType = .init(grouping: assets, by: { $0.type })
            } catch let error {
                print("Error during assets fetching: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
}
