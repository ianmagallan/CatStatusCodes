//
//  CatDetailsViewModelTests.swift
//  CatStatusCodesSwiftUITests
//
//  Created by Ian Magallan on 8/1/23.
//

import CatStatusCodesAPIMocks
@testable import CatStatusCodesSwiftUI
import XCTest

final class CatDetailsViewModelTests: XCTestCase {
    private var sut: CatDetailsViewModel!
    private var provider: MockCatProvider!
    private let url = URL(string: "https://www.google.com")!

    override func setUp() {
        super.setUp()

        provider = .init()
        provider.stubbedCatURL = url
        sut = .init(statusCode: 200, catProvider: provider)
    }

    // MARK: - isRaining -

    func testIsRaining() {
        // given
        (0 ... 600).filter { $0 < 200 || $0 > 299 }
            .forEach { statusCode in
                // when && then
                sut = .init(statusCode: statusCode)
                XCTAssertTrue(sut.isRaining)
            }
    }

    func testIsNotRaining() {
        // given
        (200 ..< 300).forEach { statusCode in
            // when && then
            sut = .init(statusCode: statusCode)
            XCTAssertFalse(sut.isRaining)
        }
    }

    // MARK: - Fetch URL -

    func testFetchCatURL() {
        // given && when && then
        XCTAssertEqual(sut.fetchCatImageURL(), url)
    }
}
