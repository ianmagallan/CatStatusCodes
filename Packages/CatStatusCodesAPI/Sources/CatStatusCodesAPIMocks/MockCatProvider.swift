//
//  MockCatProvider.swift
//  CatStatusCodesAPIMocks
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodesAPI
import Combine
import Foundation

public final class MockCatProvider: CatProviding {
    public init() {}

    public var stubbedCatResult: Result<Data, CatError>!
    public func fetchCat(statusCode _: Int) -> AnyPublisher<Data, CatError> {
        Result<Data, CatError>.Publisher(stubbedCatResult).eraseToAnyPublisher()
    }

    public var stubbedCatURL: URL!
    public func fetchCatURL(statusCode _: Int) -> URL {
        stubbedCatURL
    }
}
