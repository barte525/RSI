//
//  UserManager.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 18/04/2022.
//

import Foundation

enum UserManagerError: Error {
    case loginFailure
    case registrationFailure
    case updateFailure
    case unauthorized
}

protocol UserManagerProtocol {
    func signIn(email: String, password: String) async throws -> User?
    func signOut()
    func register(email: String, name: String, surname: String, password: String, currencyPreference: String) async throws -> User?
    func update(user: User, name: String, surname: String, email: String, currencyPreference: String) async throws -> User?
}

class UserManager: RequestProtocol, UserManagerProtocol {
    
    private let session = URLSession.shared
    private let urlString = "\(K.baseUrl)/api"
    
    func signIn(email: String, password: String) async throws -> User? {
        let loginUrl = "\(urlString)/Auth/login"
        guard let url = URL(string: loginUrl) else { throw NetworkError.invalidURL }
        let postBody = ["email": email, "password": password]
        let request = createRequest(url: url, method: "POST", body: postBody)
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200:
                guard let userDto = try? JSONDecoder().decode(UserDto.self, from: data) else { throw UserManagerError.loginFailure }
                try KeychainManager.save(account: userDto.email, service: K.keychainServiceName, token: userDto.token)
                let user = User(id: userDto.id, email: userDto.email, name: userDto.name, surname: userDto.surname, sum: userDto.sum, currencyPreference: userDto.currencyPreference)
                return user
            default:
                throw UserManagerError.loginFailure
            }
        }
        return nil
    }
    
    func signOut() {
        KeychainManager.logout()
    }
    
    func register(email: String, name: String, surname: String, password: String, currencyPreference: String) async throws -> User? {
        let registerUrl = "\(urlString)/Auth/register"
        guard let url = URL(string: registerUrl) else { throw NetworkError.invalidURL }
        let postBody = ["email": email, "name": name, "surname": surname, "password": password, "currencyPreference": currencyPreference]
        let request = createRequest(url: url, method: "POST", body: postBody)
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200:
                guard let userDto = try? JSONDecoder().decode(UserDto.self, from: data) else { throw UserManagerError.registrationFailure }
                try KeychainManager.save(account: userDto.email, service: K.keychainServiceName, token: userDto.token)
                let user = User(id: userDto.id, email: userDto.email, name: userDto.name, surname: userDto.surname, sum: userDto.sum, currencyPreference: userDto.currencyPreference)
                return user
            default:
                throw UserManagerError.registrationFailure
            }
        }
        return nil
    }
    
    func update(user: User, name: String, surname: String, email: String, currencyPreference: String) async throws -> User? {
        let updateUrl = "\(urlString)/User"
        guard let url = URL(string: updateUrl) else { throw NetworkError.invalidURL }
        let patchBody = [
            ["value": name, "path": "/Name", "op": "replace"],
            ["value": surname, "path": "/Surname", "op": "replace"],
            ["value": email, "path": "/Email", "op": "replace"],
            ["value": currencyPreference, "path": "/CurrencyPreference", "op": "replace"]
        ]
        let token = try KeychainManager.get(account: user.email, service: K.keychainServiceName)
        let request = createPatchRequest(url: url, token: token, patchBody: patchBody)
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200:
                guard let userDto = try? JSONDecoder().decode(UpdateUserDto.self, from: data) else { throw UserManagerError.updateFailure }
                let user = User(id: userDto.id, email: userDto.email, name: userDto.name, surname: userDto.surname, sum: user.sum, currencyPreference: userDto.currencyPreference)
                return user
            case 401:
                throw UserManagerError.unauthorized
            default:
                throw UserManagerError.updateFailure
            }
        }
        return nil
    }
    
}
