//
//  Cat.swift
//  CatStatusCodesModels
//
//  Created by Ian Magallan on 6/1/23.
//

public struct Cat: Equatable {
    public let statusCode: Int
    public let description: String

    public init(statusCode: Int, description: String) {
        self.statusCode = statusCode
        self.description = description
    }
}
