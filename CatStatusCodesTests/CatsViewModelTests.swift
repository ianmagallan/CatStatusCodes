//
//  CatsViewModelTests.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 6/1/23.
//

import XCTest
@testable import CatStatusCodes

final class CatsViewModelTests: XCTestCase {
    private var sut: CatsViewModel!
    private var storage: MockStorage!
    private var catFactory: MockCatFactory!
    
    override func setUp() {
        super.setUp()
        
        storage = .init()
        catFactory = .init()
        sut = .init(storage: storage, catFactory: catFactory)
        sut.didUpdateCats = {}
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
            Stub.cat(statusCode: 3)
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
    
    // MARK: - Make full description -
    
    func testMakeFullDescription() {
        // given
        let cat1 = Stub.cat(statusCode: 1, description: "Cat 1")
        let cat2 = Stub.cat(statusCode: 2, description: "Cat 2")
        let cat3 = Stub.cat(statusCode: 3, description: "Cat 3")
        catFactory.stubbedCats = [cat1, cat2, cat3]
        
        // when
        let result1 = sut.makeFullDescription(forRow: 0)
        let result2 = sut.makeFullDescription(forRow: 1)
        let result3 = sut.makeFullDescription(forRow: 2)
        
        // then
        XCTAssertEqual(result1, "1 Cat 1")
        XCTAssertEqual(result2, "2 Cat 2")
        XCTAssertEqual(result3, "3 Cat 3")
    }
    
    // MARK: - Last seen -
    
    func testUpdatesLastSeenDate() {
        // given
        let cat1 = Stub.cat(statusCode: 1)
        let cat2 = Stub.cat(statusCode: 2)
        let cat3 = Stub.cat(statusCode: 3)
        catFactory.stubbedCats = [cat1, cat2, cat3]
        
        // when
        sut.updateLastSeenDate(forRow: 0)
        sut.updateLastSeenDate(forRow: 1)
        sut.updateLastSeenDate(forRow: 2)
        
        // then
        XCTAssertNotNil(storage.stubbedStoredDates["1"])
        XCTAssertNotNil(storage.stubbedStoredDates["2"])
        XCTAssertNotNil(storage.stubbedStoredDates["3"])
    }
    
    func testLastSeenStringIsNilWhenNoDateIsAvailable() {
        // given
        catFactory.stubbedCats = [Stub.cat()]
        
        // when
        sut.start()
        let lastSeenString = sut.lastSeen(forRow: 0)
        
        // then
        XCTAssertNil(lastSeenString)
    }
    
    func testLastSeenString() {
        // given
        let expectedDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d 'at' HH:mm"
        let expectedDateString = formatter.string(from: expectedDate)
        let expectedString = String(format: Localized("cat.last_seen"), expectedDateString)
        catFactory.stubbedCats = [Stub.cat(statusCode: 1)]
        storage.stubbedStoredDates["1"] = expectedDate
        
        // when
        sut.start()
        let lastSeenString = sut.lastSeen(forRow: 0)
        
        // then
        XCTAssertEqual(lastSeenString, expectedString)
    }
    
    // MARK: - Did update cells -
    
    func testDidUpdateCellsCountWhenStarting() {
        // given
        catFactory.stubbedCats = [Stub.cat(), Stub.cat(), Stub.cat()]
        var counter = 0
        sut.didUpdateCats = { counter += 1 }
        
        // when
        sut.start()
        
        // then
        XCTAssertEqual(counter, 1)
    }
    
    func testDidUpdateCellsCountWhenUpdatingLastSeenDate() {
        // given
        catFactory.stubbedCats = [Stub.cat(), Stub.cat(), Stub.cat()]
        var counter = 0
        sut.didUpdateCats = { counter += 1 }
        
        // when
        sut.updateLastSeenDate(forRow: 0)
        sut.updateLastSeenDate(forRow: 1)
        sut.updateLastSeenDate(forRow: 2)
        
        // then
        XCTAssertEqual(counter, 3)
    }
}
