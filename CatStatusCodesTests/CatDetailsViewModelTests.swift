//
//  CatDetailsViewModelTests.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodes
import Combine
import XCTest

final class CatDetailsViewModelTests: XCTestCase {
    private var viewModel: CatDetailsViewModel!
    private var catProvider: MockCatProvider!

    override func setUp() {
        super.setUp()
        catProvider = .init()
        viewModel = CatDetailsViewModel(statusCode: 200, catProvider: catProvider)
    }

    func testFetchCatImageSuccess() {
        // given
        let expectedData = Data()
        catProvider.stubbedCatResult = .success(expectedData)

        // when && then
        let cancellable = viewModel.fetchCatImage().sink(receiveCompletion: { completion in
            XCTAssertEqual(completion, .finished)
        }, receiveValue: { data in
            XCTAssertEqual(data, expectedData)
        })

        cancellable.cancel()
    }

    func testFetchCatImageError() {
        // given
        let expectedError = CatError.wrongStatusCode(statusCode: 400)
        catProvider.stubbedCatResult = .failure(expectedError)

        // when && then
        let cancellable = viewModel.fetchCatImage().sink(receiveCompletion: { completion in
            XCTAssertEqual(completion, .failure(expectedError))
        }, receiveValue: { _ in
            XCTFail("Expected error, got value")
        })

        cancellable.cancel()
    }
}
