//
//  HttpExecutor.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import Combine
import Foundation

protocol HttpExecuting {
    func execute(request: URLRequest) -> AnyPublisher<Data, CatError>
}

final class HttpExecutor: HttpExecuting {
    let session: Sessioning

    init(session: Sessioning = Session()) {
        self.session = session
    }

    func execute(request: URLRequest) -> AnyPublisher<Data, CatError> {
        session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse else {
                    throw CatError.unknown(localizedDescription: nil)
                }

                if (200..<300).contains(response.statusCode) {
                    return data
                } else {
                    throw CatError.wrongStatusCode(statusCode: response.statusCode)
                }
            }
            .mapError { error -> CatError in
                guard let error = error as? CatError else {
                    return .unknown(localizedDescription: error.localizedDescription)
                }
                return error
            }
            .eraseToAnyPublisher()
    }
}
