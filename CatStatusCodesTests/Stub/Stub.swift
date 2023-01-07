//
//  Stub.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

import Foundation
@testable import CatStatusCodes

enum Stub {
    static let url = URL(string: "https://www.google.com")!
    static let data = Data()
    
    static func response(statusCode: Int = 200) -> HTTPURLResponse {
        .init(url: Stub.url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
    
    static func cat(statusCode: Int = 200, description: String = "🐈") -> Cat {
        .init(statusCode: statusCode, description: description)
    }
}
