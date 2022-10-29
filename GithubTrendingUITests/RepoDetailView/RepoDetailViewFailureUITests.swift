//
//  RepoDetailViewFailureUITests.swift
//  GithubTrendingUITests
//
//  Created by Bence Borsos on 2022. 10. 12..
//

import XCTest

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then

final class RepoDetailViewFailureUITests: XCTestCase {
    private var app: XCUIApplication!
    private var trendingRepoList: XCUIElement!
    
    override func setUp() {
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-trendingList-networking-success" : "1",
            "-repoDetailedView-networking-success" : "0"
        ]
        app.launch()
        let enterButton = app.buttons["enterButton"]
        XCTAssertTrue(enterButton.waitForExistence(timeout: 2), "enterButton should be visible")
        enterButton.tap()
        if #available(iOS 16.0, *) {
            trendingRepoList = app.collectionViews["trendingRepoList"]
        } else {
            trendingRepoList = app.tables["trendingRepoList"]
        }
        XCTAssertTrue(trendingRepoList.waitForExistence(timeout: 1), "trendingRepoList should be visible")
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let repoItems = trendingRepoList.cells.containing(predicate)
        XCTAssertGreaterThan(repoItems.count, 2, "There should be multiple items on the screen")
        repoItems.firstMatch.tap()
        continueAfterFailure = false
    }

    override func tearDown() {
        app = nil
        trendingRepoList = nil
    }

    func test_TrendingRepoListView_list_failedToLoad() {
        // Given
        XCTAssert(app.staticTexts["huggingface"].exists)
        XCTAssert(app.staticTexts["datasets"].exists)
        XCTAssert(app.staticTexts["🤗 The largest hub of ready-to-use datasets for ML models with fast, easy-to-use and efficient data manipulation tools"].exists)
        XCTAssert(app.staticTexts["14530"].exists)
        XCTAssert(app.staticTexts["250"].exists)
        // When
        app.swipeUp()
        // Then
        XCTAssert(app.staticTexts["huggingface"].isHittable)
        let readMeItemQuery = app.scrollViews.otherElements.containing(.any, identifier: "readMe")
        XCTAssert(!readMeItemQuery.firstMatch.isHittable)
    }
}
