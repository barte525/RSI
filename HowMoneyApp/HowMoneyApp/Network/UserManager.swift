//
//  UserManager.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 18/04/2022.
//

import Foundation

enum UserRegistrationError: Error {
    case success
    case failure
}

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
    
    func register(email: String, name: String, surname: String, password: String, currencyPreference: String) async throws -> User? {
        let registerUrl = "\(urlString)/register"
        guard let url = URL(string: registerUrl) else { throw NetworkError.invalidURL }
        let postBody = ["email": email, "name": name, "surname": surname, "password": password, "currencyPreference": currencyPreference]
        let request = createRequest(url: url, method: "POST", postBody: postBody)
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200:
                guard let userDto = try? JSONDecoder().decode(UserDto.self, from: data) else { throw UserRegistrationError.failure }
                //TODO: Save token with KeyChain - userDto.token
                let user = User(id: userDto.id, email: userDto.email, name: userDto.name, surname: userDto.surname, sum: userDto.sum, currencyPreference: userDto.currencyPreference)
                return user
            default:
                throw UserRegistrationError.failure
            }
        }
        return nil
    }
    
}
