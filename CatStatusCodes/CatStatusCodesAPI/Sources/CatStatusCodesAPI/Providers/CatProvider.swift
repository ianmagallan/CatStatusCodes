//
//  CatProviding.swift
//  CatStatusCodesAPI
//
//  Created by Ian Magallan on 6/1/23.
//

import Combine
import Foundation

public protocol CatProviding {
    func fetchCat(statusCode: Int) -> AnyPublisher<Data, CatError>
}

public final class CatProvider: CatProviding {
    private let requestFactory: RequestFactoring
    private let httpExecutor: HttpExecuting

    public init(
        requestFactory: RequestFactoring = RequestFactory(),
        httpExecutor: HttpExecuting = HttpExecutor()
    ) {
        self.requestFactory = requestFactory
        self.httpExecutor = httpExecutor
    }

    public func fetchCat(statusCode: Int) -> AnyPublisher<Data, CatError> {
        httpExecutor.execute(request: requestFactory.fetchCat(statusCode: statusCode))
    }
}
