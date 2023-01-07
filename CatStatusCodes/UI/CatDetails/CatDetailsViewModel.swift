//
//  CatDetailsViewModel.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import Combine
import Foundation

final class CatDetailsViewModel {
    private let statusCode: Int
    private let catProvider: CatProviding
    
    init(statusCode: Int, catProvider: CatProviding = CatProvider()) {
        self.statusCode = statusCode
        self.catProvider = catProvider
    }
    
    func fetchCatImage() -> AnyPublisher<Data, CatError> {
        catProvider.fetchCat(statusCode: statusCode)
    }
}
