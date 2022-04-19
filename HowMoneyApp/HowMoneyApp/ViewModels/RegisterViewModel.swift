//
//  RegisterViewModel.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 19/04/2022.
//

import Foundation
import UIKit

@MainActor
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
    
    @Published var arePasswordsIncorrect: Bool = false
    @Published var isRegistered: Bool = false
    @Published var newUser: User? = nil
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func checkPasswords() {
        if password == repeatedPassword && !password.isEmpty{
            arePasswordsIncorrect = false
        } else {
            arePasswordsIncorrect = true
        }
    }
    
    func register() {
        if !arePasswordsIncorrect {
            task = Task {
                do {
                    newUser = try await userManager.register(email: email, name: name, surname: surname, password: password, currencyPreference: currencyPreference)
                    isRegistered = true
                } catch {
                    print("Error during user registration: \(error)")
                }
            }
        }
    }
    
    
}
