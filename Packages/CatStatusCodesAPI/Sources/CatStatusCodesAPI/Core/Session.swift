//
//  Session.swift
//  CatStatusCodesAPI
//
//  Created by Ian Magallan on 6/1/23.
//

import Combine
import Foundation

public protocol Sessioning {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error>
}

public struct Session: Sessioning {
    
    public init() {}
    
    public func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .map { (data: $0.data, response: $0.response) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
