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
    var chosenAsset: UserAsset?
    
    @Published var userAssets: [UserAsset] = []
    @Published var isLoading: Bool = false
    
    @Published var areIncorrectData: Bool = false
    @Published var errorMessage: String = ""
    
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
    
    func deleteAsset(for userMail: String) {
        task = Task {
            isLoading = true
            do {
                if let safeAsset = chosenAsset {
                    let isDeleted = try await userAssetFetcher.deleteAsset(for: userMail, assetId: safeAsset.assetId)
                    areIncorrectData = !isDeleted
                    getAssets(for: userMail)
                } else {
                    areIncorrectData = true
                    errorMessage = "Please choose asset to delete."
                }
            } catch let error {
                areIncorrectData = true
                errorMessage = "Cannot delete chosen asset. Please try again."
                print("Error during deleting asset for user: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
    
    func addAsset(userId: String?, userMail: String, for chosenAsset: Asset?, amount: String) {
        guard let loggedUserId = userId else {
            areIncorrectData = true
            errorMessage = "You cannot do this operation."
            return
        }
        guard let safeAsset = chosenAsset else {
            areIncorrectData = true
            errorMessage = "Asset is not chosen. Please choose it."
            return
        }
        guard amount.isNumber else {
            areIncorrectData = true
            errorMessage = "Amount is incorrect. Please enter correct number."
            return
        }
        
        if !areIncorrectData {
            task = Task {
                do {
                    try await userAssetFetcher.createAsset(userId: loggedUserId, userMail: userMail, asset: safeAsset, amount: Double(amount)!)
                    areIncorrectData = false
                    getAssets(for: userMail)
                } catch {
                    areIncorrectData = true
                    errorMessage = "Cannot create new asset. Please try again."
                    print("Error during creating new asset for current user: \(error)")
                }
            }
        }
        
    }
}
