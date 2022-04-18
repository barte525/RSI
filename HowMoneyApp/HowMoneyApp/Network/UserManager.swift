//
//  UserManager.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 18/04/2022.
//

import Foundation

protocol UserManagerProtocol {
    func signIn()
    func signOut()
    func register()
}

class UserManager: RequestProtocol {
    
    private let session = URLSession.shared
    private let urlString = "\(K.baseUrl)/api/Auth"
    
    func signIn(email: String, password: String) {
        //TODO: Sent request to API to sign in
    }
    
    func signOut() {
        //TODO: Sign out the user
    }
    
    func register(email: String, name: String, surname: String, password: String, currencyPreference: String) async throws {
        //TODO: Sent request for register an user
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let postBody = "email=\(email)&name=\(name)&surname=\(surname)&password=\(password)&currencyPreference=\(currencyPreference)"
        let request = createRequest(url: url, method: "POST", postBody: postBody)
        let (_, response) = try await session.data(for: request)
        //TODO: Decode response data
    }
    
}
