//
//  RequestFactory.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import Foundation

protocol RequestFactoring {
    func fetchCat(statusCode: Int) -> URLRequest
}

final class RequestFactory: RequestFactoring {
    private var baseURL: URL {
        guard let url = URL(string: "https://http.cat") else {
            fatalError("Base URL could not be created")
        }

        return url
    }

    func fetchCat(statusCode: Int) -> URLRequest {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.path = "/\(statusCode).jpg"

        guard let url = components?.url else {
            fatalError("fetchCat request URL could not be created")
        }
        return .init(url: url)
    }
}
