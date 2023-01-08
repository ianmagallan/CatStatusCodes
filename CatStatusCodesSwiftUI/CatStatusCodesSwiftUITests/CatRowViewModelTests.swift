//
//  CatRowViewModelTests.swift
//  CatStatusCodesSwiftUITests
//
//  Created by Ian Magallan on 8/1/23.
//

import XCTest
@testable import CatStatusCodesSwiftUI
import CatStatusCodesModels
import CatStatusCodesModelsMocks

final class CatRowViewModelTests: XCTestCase {
    private var viewModel: CatRowViewModel!
    private let cat = Stub.cat(statusCode: 200, description: "OK")
    private let lastSeenDate = Date()

    override func setUp() {
        super.setUp()
        viewModel = .init(cat: cat, lastSeenDate: lastSeenDate)
    }

    func testSetsTitleInitially() {
        // given
        let cat = Stub.cat(statusCode: 200, description: "OK")
        viewModel = .init(cat: cat, lastSeenDate: lastSeenDate)

        // when && then
        XCTAssertEqual(viewModel.title, "200 OK")
    }

    func testSetsLastSeenInitially() {
        // given
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d 'at' HH:mm"
        let formattedDate = formatter.string(from: lastSeenDate)
        let expectedLastSeen = String(format: Localized("cat.last_seen"), formattedDate)
        
        // when && then
        XCTAssertEqual(viewModel.lastSeen, expectedLastSeen)
    }

    func testSetsCatImageNameToSeen() {
        // given && when && then
        XCTAssertEqual(viewModel.catImageName, "imCheckmarkCat")
    }

    func testSetsCatImageNameToUnseen() {
        // given && when && then
        viewModel = CatRowViewModel(cat: cat, lastSeenDate: nil)
        XCTAssertEqual(viewModel.catImageName, "imMysteriousCat")
    }
}
