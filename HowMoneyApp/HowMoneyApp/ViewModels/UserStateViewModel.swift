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
                        print(user)
                        updateAllFields(userEmail: user.email, userName: user.name, userSurname: user.surname, userCurrencyPreference: user.currencyPreference, userSum: user.sum)
                    }
                    isLogged = true
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
                        updateAllFields(userEmail: user.email, userName: user.name, userSurname: user.surname, userCurrencyPreference: user.currencyPreference, userSum: user.sum)
                    }
                    isLogged = true
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
                        updateAllFields(userEmail: user.email, userName: user.name, userSurname: user.surname, userCurrencyPreference: user.currencyPreference, userSum: user.sum)
                    }
                } catch {
                    name = loggedUser?.name ?? ""
                    surname = loggedUser?.surname ?? ""
                    email = loggedUser?.email ?? ""
                    areIncorrectData = true
                    errorMessage = "Cannot update data. Please try again."
                    print("Error during user update: \(error)")
                }
            }
        }
    }
    
    func updateAllFields(userEmail: String, userName: String, userSurname: String, userCurrencyPreference: String, userSum: Double) {
        email = userEmail
        name = userName
        surname = userSurname
        currencyPreference = userCurrencyPreference
        sum = userSum
    }
    
    func eraseAllFields() {
        updateAllFields(userEmail: "", userName: "", userSurname: "", userCurrencyPreference: "EUR", userSum: 0.0)
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
}
