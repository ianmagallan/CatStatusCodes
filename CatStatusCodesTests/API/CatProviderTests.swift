//
//  CatProviderTests.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

import Combine
import XCTest
@testable import CatStatusCodes

final class CatProviderTests: XCTestCase {
    private var cancellableBag = Set<AnyCancellable>()
    private var httpExecutor: MockHttpExecutor!
    private var sut: CatProvider!
    
    override func setUp() {
        super.setUp()
        httpExecutor = .init()
        httpExecutor.stubbedResult = .success(Stub.data)
        sut = .init(httpExecutor: httpExecutor)
    }
    
    func testFetchCatSuccess() {
        // given && when && then
        let expectation = XCTestExpectation(description: "fetch cat with success status code")
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
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchCatError() {
        httpExecutor.stubbedResult = .failure(.wrongStatusCode(statusCode: 400))
        
        let expectation = XCTestExpectation(description: "fetch cat with error status code")
        sut.fetchCat(statusCode: 400)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("fetch cat should not have succeeded")
                case .failure(let error):
                    XCTAssertEqual(error, .wrongStatusCode(statusCode: 400))
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("fetch cat should not have succeeded")
            })
            .store(in: &cancellableBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
