//
//  CatsViewModelTests.swift
//  CatStatusCodesSwiftUITests
//
//  Created by Ian Magallan on 8/1/23.
//

import CatStatusCodesModelsMocks
import CatStatusCodesStorageMocks
@testable import CatStatusCodesSwiftUI
import XCTest

final class CatsViewModelTests: XCTestCase {
    private var sut: CatsViewModel!
    private var storage: MockStorage!
    private var catFactory: MockCatFactory!

    override func setUp() {
        super.setUp()

        storage = .init()
        catFactory = .init()
        sut = .init(storage: storage, catFactory: catFactory)
    }

    // MARK: - Cache initially -

    func testTriesLoadingDatesFromCacheInitially() {
        // given
        let date1 = Date()
        let date2 = Date()
        let date3 = Date()
        catFactory.stubbedCats = [
            Stub.cat(statusCode: 1),
            Stub.cat(statusCode: 2),
            Stub.cat(statusCode: 3),
        ]
        storage.stubbedStoredDates = ["1": date1, "2": date2, "3": date3]

        // when
        sut.start()

        // then
        XCTAssertEqual(storage.invokedRetrieveDateCount, 3)
    }

    // MARK: - Sort -

    func testSortsCats() {
        // given
        let cat1 = Stub.cat(statusCode: 1)
        let cat2 = Stub.cat(statusCode: 2)
        let cat3 = Stub.cat(statusCode: 3)
        catFactory.stubbedCats = [cat1, cat2, cat3]
        storage.stubbedStoredDates = ["1": Date(), "3": Date()]

        // when
        sut.start()

        // then
        XCTAssertEqual(sut.cats, [cat1, cat3, cat2])
    }

    // MARK: - Last seen -

    func testUpdatesLastSeenDate() {
        // given
        let cat1 = Stub.cat(statusCode: 1)
        let cat2 = Stub.cat(statusCode: 2)
        let cat3 = Stub.cat(statusCode: 3)
        catFactory.stubbedCats = [cat1, cat2, cat3]

        // when
        sut.start()
        sut.updateLastSeenDate(statusCode: 1)
        sut.updateLastSeenDate(statusCode: 2)
        sut.updateLastSeenDate(statusCode: 3)

        // then
        XCTAssertNotNil(storage.stubbedStoredDates["1"])
        XCTAssertNotNil(storage.stubbedStoredDates["2"])
        XCTAssertNotNil(storage.stubbedStoredDates["3"])
    }

    func testMakeLastSeenDateIsNilWhenNoDateIsAvailable() {
        // given
        let cat = Stub.cat()
        catFactory.stubbedCats = [cat]

        // when
        sut.start()
        let lastSeenDate = sut.makeLastSeenDate(cat: cat)

        // then
        XCTAssertNil(lastSeenDate)
    }

    func testLastSeenDate() {
        // given
        let cat = Stub.cat(statusCode: 1)
        let expectedDate = Date()
        catFactory.stubbedCats = [cat]
        storage.stubbedStoredDates["1"] = expectedDate

        // when
        sut.start()
        let lastSeenDate = sut.makeLastSeenDate(cat: cat)

        // then
        XCTAssertEqual(lastSeenDate, expectedDate)
    }
}
