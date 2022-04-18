//
//  RequestProtocol.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 18/04/2022.
//

import Foundation

protocol RequestProtocol {
    func createRequest(url: URL, method: String?, postBody: String?) -> URLRequest
}

extension RequestProtocol {
    
    func createRequest(url: URL, method: String?, postBody: String? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        if let definedBody = postBody {
            request.httpBody = definedBody.data(using: String.Encoding.utf8)
        }
        return request
    }
}
