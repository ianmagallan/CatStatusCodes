//
//  CatProviderTests.swift
//  CatStatusCodesAPITests
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodesAPI
@testable import CatStatusCodesAPIMocks
import Combine
import XCTest

final class CatProviderTests: XCTestCase {
    private var cancellableBag = Set<AnyCancellable>()
    private var httpExecutor: MockHttpExecutor!
    private var requestFactory: MockRequestFactory!
    private var sut: CatProvider!

    override func setUp() {
        super.setUp()
        httpExecutor = .init()
        httpExecutor.stubbedResult = .success(Stub.data)

        requestFactory = .init()
        requestFactory.stubbedFetchCatURL = Stub.url
        requestFactory.stubbedFetchCatRequest = Stub.urlRequest
        sut = .init(requestFactory: requestFactory, httpExecutor: httpExecutor)
    }

    func testFetchCatSuccess() {
        // given
        let expectation = XCTestExpectation(description: "fetch cat with success status code")

        // when
        sut.fetchCat(statusCode: 200)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail("Expected value, got failure")
                }
            }, receiveValue: { _ in
                // Do nothing
            })
            .store(in: &cancellableBag)

        // then
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchCatError() {
        // given
        httpExecutor.stubbedResult = .failure(.wrongStatusCode(statusCode: 400))

        let expectation = XCTestExpectation(description: "fetch cat with error status code")

        // when
        sut.fetchCat(statusCode: 400)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("fetch cat should not have succeeded")
                case let .failure(error):
                    XCTAssertEqual(error, .wrongStatusCode(statusCode: 400))
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("fetch cat should not have succeeded")
            })
            .store(in: &cancellableBag)

        // then
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchCatURL() {
        // given && when
        let url = sut.fetchCatURL(statusCode: 200)

        // then
        XCTAssertEqual(url, Stub.url)
    }
}
