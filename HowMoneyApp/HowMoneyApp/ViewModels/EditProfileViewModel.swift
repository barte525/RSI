//
//  EditProfileViewModel.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 07/05/2022.
//

import Foundation

class EditProfileViewModel: ObservableObject {
    private var userManager: UserManager
    private var task: Task<(), Never>?
    
    @Published var emailTextField: String = ""
    @Published var nameTextField: String = ""
    @Published var surnameTextField: String = ""
    @Published var isUpdated: Bool = false
    @Published var loggedUser: User? = nil
    @Published var areIncorrectData: Bool = false
    @Published var errorMessage: String = ""
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func areFieldsFullfilled() -> Bool {
        return emailTextField.isValidEmail && !nameTextField.isEmpty && !surnameTextField.isEmpty
    }
    
    @MainActor
    func updateUser(user: User) {
        if areFieldsFullfilled() {
            areIncorrectData = false
        } else {
            areIncorrectData = true
        }
        if !areIncorrectData {
            task = Task {
                do {
                    loggedUser = try await userManager.update(user: user, name: nameTextField, surname: surnameTextField, email: emailTextField)
                    isUpdated = true
                } catch {
                    isUpdated = false
                    areIncorrectData = true
                    errorMessage = error.localizedDescription
                    print("Error during user update: \(error)")
                }
            }
        }
    }
}
