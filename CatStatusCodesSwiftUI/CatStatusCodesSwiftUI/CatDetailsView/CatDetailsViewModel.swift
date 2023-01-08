//
//  CatDetailsViewModel.swift
//  CatStatusCodesSwiftUI
//
//  Created by Ian Magallan on 8/1/23.
//

import CatStatusCodesAPI
import Foundation

final class CatDetailsViewModel: ObservableObject {
    @Published var isRaining = false

    private let statusCode: Int
    private let catProvider: CatProviding

    init(statusCode: Int, catProvider: CatProviding = CatProvider()) {
        self.statusCode = statusCode
        self.catProvider = catProvider

        isRaining = !(200 ..< 300).contains(statusCode)
    }

    func fetchCatImageURL() -> URL {
        catProvider.fetchCatURL(statusCode: statusCode)
    }
}
