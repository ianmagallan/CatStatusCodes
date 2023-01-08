//
//  MockRequestFactory.swift
//
//
//  Created by Ian Magallan on 8/1/23.
//

@testable import CatStatusCodesAPI
import Foundation

public final class MockRequestFactory: RequestFactoring {
    public init() {}

    public var stubbedFetchCatRequest: URLRequest!
    public func fetchCat(statusCode _: Int) -> URLRequest {
        stubbedFetchCatRequest
    }

    public var stubbedFetchCatURL: URL!
    public func fetchCatURL(statusCode _: Int) -> URL {
        stubbedFetchCatURL
    }
}
