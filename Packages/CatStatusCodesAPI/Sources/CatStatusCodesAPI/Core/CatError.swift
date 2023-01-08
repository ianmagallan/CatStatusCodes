//
//  CatError.swift
//  CatStatusCodesAPI
//
//  Created by Ian Magallan on 6/1/23.
//

public enum CatError: Error, Equatable {
    case wrongStatusCode(statusCode: Int)
    case unknown(localizedDescription: String?)
}
