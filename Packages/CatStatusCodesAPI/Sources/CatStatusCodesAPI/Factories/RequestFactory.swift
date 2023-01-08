//
//  RequestFactory.swift
//  CatStatusCodesAPI
//
//  Created by Ian Magallan on 6/1/23.
//

import Foundation

public protocol RequestFactoring {
    func fetchCat(statusCode: Int) -> URLRequest
}

public final class RequestFactory: RequestFactoring {
    private var baseURL: URL {
        guard let url = URL(string: "https://http.cat") else {
            fatalError("Base URL could not be created")
        }

        return url
    }
    
    public init() {}

    public func fetchCat(statusCode: Int) -> URLRequest {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.path = "/\(statusCode).jpg"

        guard let url = components?.url else {
            fatalError("fetchCat request URL could not be created")
        }
        return .init(url: url)
    }
}
