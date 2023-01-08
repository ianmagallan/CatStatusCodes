//
//  MockRequestFactory.swift
//  
//
//  Created by Ian Magallan on 8/1/23.
//

import Foundation
@testable import CatStatusCodesAPI

public final class MockRequestFactory: RequestFactoring {
    
    public init() {}
    
    public var stubbedFetchCatRequest: URLRequest!
    public func fetchCat(statusCode: Int) -> URLRequest {
        stubbedFetchCatRequest
    }
    
    public var stubbedFetchCatURL: URL!
    public func fetchCatURL(statusCode: Int) -> URL {
        stubbedFetchCatURL
    }
}
