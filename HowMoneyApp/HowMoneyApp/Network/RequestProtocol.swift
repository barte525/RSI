//
//  RequestProtocol.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 18/04/2022.
//

import Foundation

protocol RequestProtocol {
    func createRequest(url: URL, method: String?, postBody: [String: String]?) -> URLRequest
}

extension RequestProtocol {
    
    func createRequest(url: URL, method: String?, postBody: [String: String]? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        if let definedBody = postBody {
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let bodyData = try? JSONSerialization.data(
                withJSONObject: definedBody,
                options: []
            )
            request.httpBody = bodyData
        }
        return request
    }
}
