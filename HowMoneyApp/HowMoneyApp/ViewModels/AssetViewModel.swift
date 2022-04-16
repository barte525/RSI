//
//  AssetViewModel.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 15/04/2022.
//

import Foundation

@MainActor
class AssetViewModel: ObservableObject {
    
    private let assetFetcher: AssetFetcher
    private var task: Task<(), Never>?
    
    @Published var assets: [Asset] = []
    
    init(fetcher: AssetFetcher) {
        self.assetFetcher = fetcher
    }
    
    func getAllAssets() {
        task = Task {
            do {
                assets = try await assetFetcher.getAll()
            } catch let error {
                print("Error during assets fetching: \(error.localizedDescription)")
            }
        }
    }
}
