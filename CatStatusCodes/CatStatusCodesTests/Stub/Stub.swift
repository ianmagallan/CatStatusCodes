//
//  Stub.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodes
import CatStatusCodesModels
import Foundation

enum Stub {
    static func cat(statusCode: Int = 200, description: String = "🐈") -> Cat {
        .init(statusCode: statusCode, description: description)
    }
}
