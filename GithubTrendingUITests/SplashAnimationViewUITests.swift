//
//  SplashAnimationViewUITests.swift
//  GithubTrendingBorsosbeUITests
//
//  Created by Bence Borsos on 2022. 10. 11..
//

import XCTest

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then

final class SplashAnimationViewUITests: XCTestCase {
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
    }
    
    override func tearDown() {
        app = nil
        trendingRepoList = nil
    }
    
    func test_SplashAnimationView_enterButton_shouldNavigate() {
        // Given
        let enterButton = app.buttons["enterButton"]
        XCTAssertTrue(enterButton.waitForExistence(timeout: 2), "enterButton should be visible")
        // When
        enterButton.tap()
        // Then
        XCTAssertTrue(trendingRepoList.waitForExistence(timeout: 2), "trendingRepoList should be visible")
    }
}
