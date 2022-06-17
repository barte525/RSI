//
//  UserStateViewModel.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 07/05/2022.
//

import Foundation
import SwiftUI

@MainActor
class UserStateViewModel: ObservableObject {
    
    private var userManager: UserManager
    private var userAssetFetcher: UserAssetFetcher
    private var task: Task<(), Never>?
    static let sharedInstance = UserStateViewModel(userManager: UserManager(), fetcher: UserAssetFetcher())
    
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var password: String = ""
    @Published var repeatedPassword: String = ""
    @Published var currencyPreference: String = "EUR"
    @Published var sum: Double = 0.0
    
    @Published var arePasswordsIncorrect: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLogged: Bool = false
    @Published var loggedUser: User? = nil
    @Published var areIncorrectData: Bool = false
    
    @Published var oldPasswordTextField: String = ""
    @Published var newPasswordTextField: String = ""
    @Published var repeatedNewPasswordTextField: String = ""
    
    @Published var isPasswordReseted: Bool = false
    
    init(userManager: UserManager, fetcher: UserAssetFetcher) {
        self.userManager = userManager
        self.userAssetFetcher = fetcher
    }
    
    func register() {
        checkFieldsForRegister()
        
        if !areIncorrectData {
            task = Task {
                do {
                    loggedUser = try await userManager.register(email: email, name: name, surname: surname, password: password, currencyPreference: currencyPreference)
                    if let user = loggedUser {
                        updateAllFields(userEmail: user.email, userName: user.name, userSurname: user.surname, userCurrencyPreference: user.currencyPreference)
                    }
                    isLogged = true
                } catch NetworkError.noConnection {
                    isLogged = false
                    areIncorrectData = true
                    errorMessage = "No connection. Pleasy try again later."
                } catch {
                    isLogged = false
                    errorMessage = "Please enter all fields with valid values."
                    print("Error during user registration: \(error)")
                }
            }
        }
    }
    
    func signIn() {
        checkFieldsForLogin()
        
        if !areIncorrectData {
            task = Task {
                do {
                    loggedUser = try await userManager.signIn(email: email, password: password)
                    if let user = loggedUser {
                        updateAllFields(userEmail: user.email, userName: user.name, userSurname: user.surname, userCurrencyPreference: user.currencyPreference)
                    }
                    isLogged = true
                } catch NetworkError.noConnection {
                    isLogged = false
                    areIncorrectData = true
                    errorMessage = "No connection. Pleasy try again later."
                } catch {
                    isLogged = false
                    areIncorrectData = true
                    errorMessage = "Incorrect email or password."
                    print("Error during signing in: \(error)")
                }
            }
        }
    }
    
    func signOut() {
        userManager.signOut()
        eraseAllFields()
        isLogged = false
    }
    
    func updateUser() {
        if !areIncorrectData {
            task = Task {
                do {
                    loggedUser = try await userManager.update(user: loggedUser!, name: name, surname: surname, email: email, currencyPreference: currencyPreference)
                    if let user = loggedUser {
                        updateAllFields(userEmail: user.email, userName: user.name, userSurname: user.surname, userCurrencyPreference: user.currencyPreference)
                    }
                } catch {
                    name = loggedUser?.name ?? ""
                    surname = loggedUser?.surname ?? ""
                    email = loggedUser?.email ?? ""
                    areIncorrectData = true
                    errorMessage = "Cannot update data. Please try again."
                    print("Error during user update: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func changePassword() {
        validateChangedPasswords()
        if !areIncorrectData {
            task = Task {
                do {
                    let isChanged = try await userManager.changePassword(userMail: loggedUser!.email, oldPassword: oldPasswordTextField, newPassword: newPasswordTextField)
                    if !isChanged {
                        areIncorrectData = true
                        errorMessage = "Cannot change password. Please try again."
                    }
                } catch {
                    areIncorrectData = true
                    errorMessage = "Cannot change password. Please try again."
                    print("Error during passwords changing: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func resetPassword() {
        guard email.isValidEmail else {
            areIncorrectData = true
            errorMessage = "You've enter invalid email. Please fix it."
            return
        }
        if !areIncorrectData {
            task = Task {
                do {
                    isPasswordReseted = try await userManager.resetPassword(email: email)
                } catch {
                    isPasswordReseted = false
                    areIncorrectData = true
                    errorMessage = "Cannot reset password. Please try again."
                    print("Error during password reseting: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateAllFields(userEmail: String, userName: String, userSurname: String, userCurrencyPreference: String) {
        email = userEmail
        name = userName
        surname = userSurname
        currencyPreference = userCurrencyPreference
    }
    
    func eraseAllFields() {
        updateAllFields(userEmail: "", userName: "", userSurname: "", userCurrencyPreference: "EUR")
        password = ""
        repeatedPassword = ""
    }
    
    func checkPasswords() {
        if password == repeatedPassword && !password.isEmpty{
            arePasswordsIncorrect = false
        } else {
            arePasswordsIncorrect = true
        }
    }
    
    func isEmailValid() -> Bool {
        return email.isValidEmail
    }
    
    func isPasswordValid() -> Bool {
        checkPasswords()
        return !password.isEmpty && !arePasswordsIncorrect
    }
    
    func checkFieldsForLogin() {
        if !isEmailValid() {
            areIncorrectData = true
            errorMessage = "Please enter valid email."
        } else if password.isEmpty {
            areIncorrectData = true
            errorMessage = "Please enter passwords."
        } else {
            areIncorrectData = false
            errorMessage = ""
        }
    }
    
    func checkFieldsForRegister() {
        if !isEmailValid() {
            areIncorrectData = true
            errorMessage = "Please enter valid email."
        } else if !isPasswordValid() {
            areIncorrectData = true
            errorMessage = "Please enter passwords."
        } else {
            areIncorrectData = false
            errorMessage = ""
        }
    }
    
    func fetchSum() {
        task = Task {
            do {
                if let user = loggedUser {
                    sum = try await userAssetFetcher.getSum(for: user.email)!
                }
            } catch {
                errorMessage = "Cannot fetch data. Please try again."
                print("Error during getting sum for user: \(error)")
            }
        }
    }
    
    func showAlertWithResetPasswordMessage() {
        areIncorrectData = true
        errorMessage = "You'll get an email with new password. Please change it after logging."
    }
    
    private func validateChangedPasswords() {
        guard !newPasswordTextField.isEmpty && !oldPasswordTextField.isEmpty else {
            errorMessage = "Passwords cannot be empty. Please enter valid ones."
            areIncorrectData = true
            return
        }
        guard newPasswordTextField == repeatedNewPasswordTextField else {
            errorMessage = "Passwords have to be the same. Please fix it."
            areIncorrectData = true
            return
        }
        areIncorrectData = false
    }
}
