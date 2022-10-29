//
//  RepoAvatarImageViewModelTests.swift
//  GithubTrendingTests
//
//  Created by Bence Borsos on 2022. 10. 11..
//

import XCTest
@testable import GithubTrending
import Combine

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Testing Structure: Given, When, Then

final class RepoAvatarImageViewModelTests: XCTestCase {
    var sut: RepoAvatarImageViewModel! // System Under Test
    var mockImageFetchingService: MockImageFetchingService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockImageFetchingService = MockImageFetchingService()
        let url = URL(string: "mockURL")!
        sut = RepoAvatarImageViewModel(url: url, imageFetchingService: mockImageFetchingService)
        cancellables = []
    }

    override func tearDown() {
        mockImageFetchingService = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func test_RepoAvatarImageViewModel_fetchImage_PopulatesImageData() async {
        // given
        let expectation = XCTestExpectation(description: "fetchImage() populates imageData")
        let rawImageData = mockImageFetchingService.loadAvatarImageSample()
        // when
        await sut.fetchImage()
        // then
        sut.$imageData
            .sink { value in
                XCTAssertTrue(value != nil)
                XCTAssertEqual(value, rawImageData)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}
