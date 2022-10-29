//
//  TrendingRepoListViewModelTests.swift
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

final class TrendingRepoListViewModelTests: XCTestCase {
    var sut: TrendingRepoListViewModel! // System Under Test
    var mockTrendingScraperService: MockTrendingScraperService!
    var mockNetworkingManager: MockNetworkingManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockTrendingScraperService = MockTrendingScraperService()
        mockNetworkingManager = MockNetworkingManager(networkEnviroment: .dev)
        sut = TrendingRepoListViewModel(scraperService: mockTrendingScraperService, networkingManager: mockNetworkingManager)
        cancellables = []
    }
    
    override func tearDown() {
        mockTrendingScraperService = nil
        mockNetworkingManager = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_TrendingRepoListViewModel_Repos_PopulatedOnAppear() {
        // given
        let expectation = XCTestExpectation(description: "Fetched repos on ViewModelAppear")
        let firstItem = ScrapedRepoModel(ownerName: "ashawkey", repoName: "stable-dreamfusion")
        let secondItem = ScrapedRepoModel(ownerName: "huggingface", repoName: "datasets")
        mockTrendingScraperService.scrapedRepoModelsResults = [firstItem, secondItem]
        // when
        sut.onViewModelAppear()
        // then
        sut.$repos
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(sut.repos[0].owner.name, firstItem.ownerName)
        XCTAssertEqual(sut.repos[1].owner.name, secondItem.ownerName)
    }
    
    func test_TrendingRepoListViewModel_reload_NewReposPopulated() {
        // given
        let mainExpectation = XCTestExpectation(description: "Fetched from reload function, replace old elements")
        let preExpectation1 = XCTestExpectation(description: "OnAppear populates oldItem to repos")
        let oldItem = ScrapedRepoModel(ownerName: "ashawkey", repoName: "stable-dreamfusion")
        mockTrendingScraperService.scrapedRepoModelsResults = [oldItem]
        sut.onViewModelAppear()
        sut.$repos
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value.count, 1)
                XCTAssertEqual((value[0] as RepoModel).owner.name, oldItem.ownerName)
                preExpectation1.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [preExpectation1], timeout: 1)
        cancellables.removeAll()
        // when
        let newItem = ScrapedRepoModel(ownerName: "huggingface", repoName: "datasets")
        mockTrendingScraperService.scrapedRepoModelsResults = [newItem]
        sut.reload()
        // then
        sut.$repos
            .dropFirst()
            .sink { value in
                XCTAssertNotEqual(value.count, 2)
                XCTAssertEqual((value.first! as RepoModel).owner.name, newItem.ownerName)
                mainExpectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [mainExpectation], timeout: 1)
    }
}
