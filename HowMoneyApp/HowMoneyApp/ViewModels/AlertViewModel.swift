//
//  AlertViewModel.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 15/06/2022.
//

import Foundation

@MainActor
class AlertViewModel: ObservableObject {
    
    private let alertFetcher: AlertFetcher
    private var task: Task<(), Never>?
    
    @Published var alerts: [AssetAlert] = []
    @Published var chosenAsset: Asset? = nil
    @Published var chosenAlertToDelete: AssetAlert? = nil
    @Published var targetValueTextField: String = ""
    @Published var targetValueCurrency: String = "EUR"
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var isAlertSet: Bool = false
    
    @Published var areIncorrectData: Bool = false
    @Published var errorMessage: String = ""
    
    var filteredAlerts: [AssetAlert] {
        return alerts.filter { alert in
            searchText.isEmpty || alert.asset_name.lowercased().contains(searchText.lowercased())
        }
    }
    
    init(fetcher: AlertFetcher) {
        self.alertFetcher = fetcher
    }
    
    func getAlerts(for userMail: String) {
        task = Task {
            isLoading = true
            do {
                alerts = try await alertFetcher.getAlerts(for: userMail)
            } catch let error {
                print("Error during alerts fetching for user: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
    
    func deleteAlert(for userMail: String) {
        guard let alertId = chosenAlertToDelete?.id else {
            areIncorrectData = true
            errorMessage = "Please choose alert."
            return
        }
        if !areIncorrectData {
            task = Task {
                isLoading = true
                do {
                    let isDeleted = try await alertFetcher.deleteAlert(for: userMail, alertId: alertId)
                    areIncorrectData = !isDeleted
                    if !areIncorrectData {
                        errorMessage = "Cannot delete chosen alert. Please try again."
                    }
                } catch let error {
                    areIncorrectData = true
                    errorMessage = "Cannot delete chosen alert. Please try again."
                    print("Error during deleting alert for user: \(error.localizedDescription)")
                }
                isLoading = false
            }
        }
    }
    
    func addAlert(userMail: String) {
        guard let safeAsset = chosenAsset else {
            areIncorrectData = true
            errorMessage = "Asset is not chosen. Please choose it."
            return
        }
        guard targetValueTextField.isNumber else {
            areIncorrectData = true
            errorMessage = "Target value is incorrect. Please enter correct number."
            return
        }
        
        if !areIncorrectData {
            task = Task {
                do {
                    isAlertSet = try await alertFetcher.postAlert(userMail: userMail, targetValue: Double(targetValueTextField)!, targetValueCurrency: targetValueCurrency, alertAssetName: safeAsset.name)
                    if isAlertSet {
                        areIncorrectData = false
                        getAlerts(for: userMail)
                    }
                } catch {
                    areIncorrectData = true
                    errorMessage = "Cannot create new alert. Please check network connection."
                    print("Error during creating new alert for current user: \(error)")
                }
            }
        }
    }
}
