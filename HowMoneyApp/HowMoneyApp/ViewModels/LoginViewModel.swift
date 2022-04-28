//
//  LoginViewModel.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 28/04/2022.
//

import Foundation
import UIKit

@MainActor
class LoginViewModel: ObservableObject {
    
    private var userManager: UserManager
    private var task: Task<(), Never>?
    
    @Published var emailTextField: String = ""
    @Published var passwordTextField: String = ""
    @Published var isLogged: Bool = false
    @Published var loggedUser: User? = nil
    @Published var areIncorrectData: Bool = false
    @Published var errorMessage: String = ""
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func areFieldsFullfilled() -> Bool {
        return emailTextField.isValidEmail && !passwordTextField.isEmpty
    }
    
    func signIn() {
        if areFieldsFullfilled() {
            areIncorrectData = false
        } else {
            areIncorrectData = true
        }
        if !areIncorrectData {
            task = Task {
                do {
                    loggedUser = try await userManager.signIn(email: emailTextField, password: passwordTextField)
                    isLogged = true
                } catch {
                    isLogged = false
                    areIncorrectData = true
                    errorMessage = error.localizedDescription
                    print("Error during signing in: \(error)")
                }
            }
        }
    }
    
    
}
