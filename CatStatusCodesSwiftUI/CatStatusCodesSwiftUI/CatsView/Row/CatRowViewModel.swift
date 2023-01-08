//
//  CatRowViewModel.swift
//  CatStatusCodesSwiftUI
//
//  Created by Ian Magallan on 8/1/23.
//

import CatStatusCodesModels
import Foundation

final class CatRowViewModel: ObservableObject {
    @Published var catImageName = Constants.unseenCatImageName
    @Published var title = ""
    @Published var lastSeen = ""

    let statusCode: Int

    init(cat: Cat, lastSeenDate: Date?) {
        statusCode = cat.statusCode

        title = "\(cat.statusCode) \(cat.description)"
        lastSeen = lastSeenDate.flatMap(makeLastSeenDate) ?? ""
        catImageName = makeCatImageName(hasBeenAlreadySeen: !lastSeen.isEmpty)
    }

    private func makeLastSeenDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d 'at' HH:mm"
        let formattedDate = formatter.string(from: date)

        return String(format: Localized("cat.last_seen"), formattedDate)
    }

    private func makeCatImageName(hasBeenAlreadySeen: Bool) -> String {
        if hasBeenAlreadySeen {
            return Constants.seenCatImageName
        } else {
            return Constants.unseenCatImageName
        }
    }
}

extension CatRowViewModel {
    private enum Constants {
        static let seenCatImageName = "imCheckmarkCat"
        static let unseenCatImageName = "imMysteriousCat"
    }
}
