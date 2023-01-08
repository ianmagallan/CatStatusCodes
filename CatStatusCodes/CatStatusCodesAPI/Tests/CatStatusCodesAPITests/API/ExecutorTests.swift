//
//  ExecutorTests.swift
//  CatStatusCodesAPITests
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodesAPI
@testable import CatStatusCodesAPIMocks
import Combine
import Foundation
import XCTest

final class HttpExecutorTest: XCTestCase {
    private var cancellableBag = Set<AnyCancellable>()
    private var mockSession: MockSession!
    private var sut: HttpExecutor!

    override func setUp() {
        super.setUp()
        mockSession = .init()
        mockSession.stubbedData = Stub.data
        mockSession.stubbedResponse = Stub.response()

        sut = .init(session: mockSession)
    }

    func testExecutorParsesSuccessfully() {
        // given
        let request = URLRequest(url: Stub.url)
        mockSession.stubbedResponse = Stub.response(statusCode: 200)
        var receivedData: Data!

        // when
        sut.execute(request: request)
            .sink { _ in } receiveValue: { receivedData = $0 }
            .store(in: &cancellableBag)

        // then
        XCTAssertNotNil(receivedData)
    }

    func testExecutorWrongStatusCodeError() {
        // given
        let request = URLRequest(url: Stub.url)
        mockSession.stubbedResponse = Stub.response(statusCode: 400)

        // when && then
        sut.execute(request: request)
            .sink { result in
                guard case let .failure(.wrongStatusCode(statusCode)) = result else {
                    XCTFail("Wrong error type")
                    return
                }

                XCTAssertEqual(statusCode, 400)
            } receiveValue: { _ in
                XCTFail("Expected error, got value")
            }
            .store(in: &cancellableBag)
    }

    func testExecutorUnknownError() {
        // given
        let request = URLRequest(url: Stub.url)
        mockSession.stubbedResponse = URLResponse(url: Stub.url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)

        // when && then
        sut.execute(request: request)
            .sink { result in
                guard case let .failure(.unknown(localizedDescription)) = result else {
                    XCTFail("Wrong error type")
                    return
                }

                XCTAssertNil(localizedDescription)
            } receiveValue: { _ in
                XCTFail("Expected error, got value")
            }
            .store(in: &cancellableBag)
    }
}
