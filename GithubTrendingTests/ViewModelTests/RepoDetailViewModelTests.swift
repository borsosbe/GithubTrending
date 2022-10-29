//
//  RepoDetailViewModelTests.swift
//  GithubTrendingTests
//
//  Created by Bence Borsos on 2022. 10. 10..
//

import XCTest
@testable import GithubTrending
import Combine

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Testing Structure: Given, When, Then

final class RepoDetailViewModelTests: XCTestCase {
    var sut: RepoDetailViewModel! // System Under Test
    var mockNetworkingManager: MockNetworkingManager!
    var mockReadMeFetchingService: MockReadMeFetchingService!
    var cancellables: Set<AnyCancellable>!
    var repo: RepoModel!
    
    override func setUp() {
        super.setUp()
        mockNetworkingManager = MockNetworkingManager(networkEnviroment: .dev)
        repo = RepoModel(id: 0, name: "datasets", owner: OwnerModel(id: 0, name: "huggingface", githubURL: URL(string: "https://github.com/huggingface")!, avatarURL: URL(string: "https://avatars.githubusercontent.com/u/25720743?v=4")!), description: "🤗 The largest hub of ready-to-use datasets for ML models with fast, easy-to-use and efficient data manipulation tools", stargazersCount: 79, subscribersCount: 60, language: "Python")
        mockReadMeFetchingService = MockReadMeFetchingService()
        sut = RepoDetailViewModel(repo: repo, networkingManager: mockNetworkingManager, readMeFetchingService: mockReadMeFetchingService)
        cancellables = []
    }

    override func tearDown() {
        mockNetworkingManager = nil
        mockReadMeFetchingService = nil
        repo = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_TrendingRepoListViewModel_markDownURL_PopulatedOnAppear() {
        // given
        let expectation = XCTestExpectation(description: "Fetched markDownUR on ViewModelAppear")
        let awaitedMarkDownURLFromMockResponse: URL = URL(string: "https://raw.githubusercontent.com/huggingface/datasets/main/README.md")!
        // when
        sut.onViewModelAppear()
        // then
        sut.$markDownURL
            .dropFirst()
            .sink { value in
                XCTAssertTrue(value != nil)
                XCTAssertEqual(value!, awaitedMarkDownURLFromMockResponse)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_TrendingRepoListViewModel_readMeMarkDown_PopulatedOnAppear() {
        // given
        let expectation = XCTestExpectation(description: "Fetched readMeMarkDown on ViewModelAppear")
        let rawReadMeData = mockReadMeFetchingService.loadReadMeSample()
        // when
        sut.onViewModelAppear()
        // then
        sut.$readMeMarkDown
            .dropFirst()
            .sink { value in
                XCTAssertTrue(value != nil)
                XCTAssertEqual(value!, String(data: rawReadMeData!, encoding: .utf8))
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}
