//
//  TrendingRepoListViewFailureUITests.swift
//  GithubTrendingUITests
//
//  Created by Bence Borsos on 2022. 10. 12..
//

import XCTest

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then

final class TrendingRepoListViewFailureUITests: XCTestCase {
    private var app: XCUIApplication!
    private var trendingRepoList: XCUIElement!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-trendingList-networking-success" : "0"]
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
    
    func test_TrendingRepoListView_list_failedToLoad() {
        // Given
        let refreshButton = app.buttons["refreshButton"]
        XCTAssertTrue(refreshButton.exists, "refreshButton should be visible")
        XCTAssertFalse(trendingRepoList.exists, "trendingRepoList should be visible")
        // When
        let loadingIndicator = app.activityIndicators["loadingIndicator"]
        XCTAssertTrue(loadingIndicator.exists, "loadingIndicator should be visible")
        // Then
        XCTAssertFalse(loadingIndicator.waitForExistence(timeout: 1), "loadingIndicator should not be visible")
        XCTAssert(app.staticTexts["[⚠️] Unknown error occured"].exists)
    }
}
