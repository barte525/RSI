//
//  UserAssetViewModel.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 27/04/2022.
//

import Foundation

@MainActor
class UserAssetViewModel: ObservableObject {
    
    private let userAssetFetcher: UserAssetFetcher
    private var task: Task<(), Never>?
    
    @Published var userAssets: [UserAsset] = []
    @Published var isLoading: Bool = false
    
    init(fetcher: UserAssetFetcher) {
        self.userAssetFetcher = fetcher
    }
    
    func getAssets(for userMail: String) {
        task = Task {
            isLoading = true
            do {
                userAssets = try await userAssetFetcher.getAssets(for: userMail)
            } catch let error {
                print("Error during assets for user fetching: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
    
}
