//
//  TrendingRepoListViewUITests.swift
//  GithubTrendingUITests
//
//  Created by Bence Borsos on 2022. 10. 11..
//

import XCTest

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then

final class TrendingRepoListViewUITests: XCTestCase {
    private var app: XCUIApplication!
    private var trendingRepoList: XCUIElement!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-trendingList-networking-success" : "1"]
        app.launch()
        if #available(iOS 16.0, *) {
            trendingRepoList = app.collectionViews["trendingRepoList"]
        } else {
            trendingRepoList = app.tables["trendingRepoList"]
        }
        let enterButton = app.buttons["enterButton"]
        XCTAssertTrue(enterButton.waitForExistence(timeout: 2), "enterButton should be visible")
        enterButton.tap()
    }
    
    override func tearDown() {
        app = nil
        trendingRepoList = nil
    }
    
    func test_TrendingRepoListView_list_shouldShowRepos() {
        // Given
        XCTAssertTrue(trendingRepoList.waitForExistence(timeout: 1), "trendingRepoList should be visible")
        // When
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let repoItems = trendingRepoList.cells.containing(predicate)
        XCTAssertGreaterThan(repoItems.count, 2, "There should be multiple items on the screen")
        //Then
        XCTAssert(app.staticTexts["huggingface"].exists)
        XCTAssert(app.staticTexts["datasets"].exists)
        XCTAssert(app.staticTexts["🤗 The largest hub of ready-to-use datasets for ML models with fast, easy-to-use and efficient data manipulation tools"].exists)
        XCTAssert(app.staticTexts["14530"].exists)
        XCTAssert(app.staticTexts["250"].exists)
    }
    
    func test_TrendingRepoListView_refreshButton_shoulBeTappable() {
        // Given
        XCTAssertTrue(trendingRepoList.waitForExistence(timeout: 1), "trendingRepoList should be visible")
        // When
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let repoItems = trendingRepoList.cells.containing(predicate)
        XCTAssertGreaterThan(repoItems.count, 2, "There should be multiple items on the screen")
        let refreshButton = app.buttons["refreshButton"]
        refreshButton.tap()
        //Then
        let loadingIndicator = app.activityIndicators["loadingIndicator"]
        XCTAssertTrue(loadingIndicator.waitForExistence(timeout: 0.2), "loadingIndicator should be visible")
    }
    
    func test_TrendingRepoListView_repoRow_shoulBeTappable() {
        // Given
        XCTAssertTrue(trendingRepoList.waitForExistence(timeout: 1), "trendingRepoList should be visible")
        // When
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let repoItems = trendingRepoList.cells.containing(predicate)
        XCTAssertGreaterThan(repoItems.count, 2, "There should be multiple items on the screen")
        repoItems.firstMatch.tap()
        //Then
        let repoRowItemQuery = app.scrollViews.otherElements.containing(.any, identifier: "repoRow")
        let repoRow = repoRowItemQuery.firstMatch
        XCTAssertTrue(repoRow.waitForExistence(timeout: 0.2), "repoRowView should be visible")
    }
    
    func test_TrendingRepoListView_list_shoulBeScrollabe() {
        // Given
        XCTAssertTrue(trendingRepoList.waitForExistence(timeout: 1), "trendingRepoList should be visible")
        // When
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let repoItems = trendingRepoList.cells.containing(predicate)
        XCTAssertGreaterThan(repoItems.count, 0, "There should be multiple items on the screen")
        app.swipeUp()
        //Then
        XCTAssertTrue(trendingRepoList.firstMatch.waitForExistence(timeout: 2), "waiting for scroll")
        XCTAssert(app.staticTexts["ashawkey"].exists)
        XCTAssert(app.staticTexts["stable-dreamfusion"].exists)
        XCTAssert(app.staticTexts["A pytorch implementation of text-to-3D dreamfusion, powered by stable diffusion."].exists)
        XCTAssert(app.staticTexts["1858"].exists)
        XCTAssert(app.staticTexts["39"].exists)
        XCTAssert(app.staticTexts["Python"].exists)
    }
}
