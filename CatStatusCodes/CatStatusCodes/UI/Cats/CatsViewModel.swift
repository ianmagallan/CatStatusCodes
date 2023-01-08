//
//  CatsViewModel.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import CatStatusCodesStorage
import CatStatusCodesModels
import Foundation

final class CatsViewModel {
    // MARK: - Actions -

    var didUpdateCats: (() -> Void)!

    // MARK: - Public properties -

    private(set) lazy var cats = catFactory.makeCats() {
        didSet {
            didUpdateCats()
        }
    }

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

    // MARK: - Full description -

    func makeFullDescription(forRow index: Int) -> String {
        let cat = cats[index]
        return "\(cat.statusCode) \(cat.description)"
    }

    // MARK: - Last seen -

    func updateLastSeenDate(forRow index: Int) {
        let statusCode = cats[index].statusCode
        let key = String(statusCode)
        let currentDate = Date()
        storage.storeDate(currentDate, forKey: key)
        cachedDates[statusCode] = currentDate
        sortCats()
    }

    func lastSeen(forRow index: Int) -> String? {
        let statusCode = cats[index].statusCode
        guard let date = makeLastSeenDate(statusCode: statusCode) else {
            return nil
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d 'at' HH:mm"
        let formattedDate = formatter.string(from: date)

        return String(format: Localized("cat.last_seen"), formattedDate)
    }

    private func makeLastSeenDate(statusCode: Int) -> Date? {
        guard let cachedDate = cachedDates[statusCode] else {
            return storage.retrieveDate(forKey: String(statusCode))
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
