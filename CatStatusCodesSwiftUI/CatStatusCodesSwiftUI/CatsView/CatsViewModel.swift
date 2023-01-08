//
//  CatsViewModel.swift
//  CatStatusCodesSwiftUI
//
//  Created by Ian Magallan on 8/1/23.
//

import CatStatusCodesModels
import CatStatusCodesStorage
import Foundation

final class CatsViewModel: ObservableObject {
    // MARK: - Public properties -

    @Published var cats = [Cat]()

    // MARK: - Private properties -

    private var seenCats = [Cat]()
    private var nonSeenCats = [Cat]()
    private var cachedDates = [Int: Date]()

    // MARK: - Dependencies -

    private let storage: Storing
    private let catFactory: CatFactoring

    // MARK: - Init -

    init(storage: Storing = Storage(), catFactory: CatFactoring = CatFactory()) {
        self.storage = storage
        self.catFactory = catFactory
    }

    func start() {
        cats = catFactory.makeCats()
        loadDatesInCache()
        sortCats()
    }

    private func loadDatesInCache() {
        cats.forEach { cat in
            guard let date = storage.retrieveDate(forKey: String(cat.statusCode)) else {
                return
            }
            cachedDates[cat.statusCode] = date
        }
    }

    // MARK: - Last seen -

    func updateLastSeenDate(statusCode: Int) {
        guard let cat = cats.first(where: { $0.statusCode == statusCode }) else {
            fatalError("Cat not found")
        }
        let key = String(cat.statusCode)
        let currentDate = Date()
        storage.storeDate(currentDate, forKey: key)
        cachedDates[cat.statusCode] = currentDate
        sortCats()
    }

    func makeLastSeenDate(cat: Cat) -> Date? {
        guard let cachedDate = cachedDates[cat.statusCode] else {
            return storage.retrieveDate(forKey: String(cat.statusCode))
        }

        return cachedDate
    }

    // MARK: - Utils -

    private func sortCats() {
        seenCats.removeAll()
        nonSeenCats.removeAll()
        cats.forEach { cat in
            if cachedDates[cat.statusCode] == nil {
                nonSeenCats.append(cat)
            } else {
                seenCats.append(cat)
            }
        }
        cats = seenCats.sorted { $0.statusCode < $1.statusCode } + nonSeenCats
    }
}
