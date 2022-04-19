//
//  RegisterViewModel.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 19/04/2022.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    private var userManager: UserManager
    private var task: Task<(), Never>?
    static let sharedInstance = RegisterViewModel(userManager: UserManager())
    
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var password: String = ""
    @Published var repeatedPassword: String = ""
    @Published var currencyPreference: String = "EUR"
    @Published var arePasswordsCorrect: Bool = false
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func checkPasswords() {
        if password == repeatedPassword {
            arePasswordsCorrect = true
        } else {
            arePasswordsCorrect = false
        }
    }
    
    func register() {
        if arePasswordsCorrect == true {
            task = Task {
                do {
                    try await userManager.register(email: email, name: name, surname: surname, password: password, currencyPreference: currencyPreference)
                } catch {
                    print("Error during user registration: \(error)")
                }
            }
        }
    }
    
    
}
