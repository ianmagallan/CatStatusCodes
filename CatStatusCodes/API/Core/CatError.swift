//
//  CatError.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

enum CatError: Error, Equatable {
    case wrongStatusCode(statusCode: Int)
    case unknown(localizedDescription: String?)
}
