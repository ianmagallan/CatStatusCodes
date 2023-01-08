//
//  Stub.swift
//  CatStatusCodesAPITests
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodesAPI
import Foundation

enum Stub {
    static let url = URL(string: "https://www.google.com")!
    static let data = Data()

    static func response(statusCode: Int = 200) -> HTTPURLResponse {
        .init(url: Stub.url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
