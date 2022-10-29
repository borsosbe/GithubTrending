//
//  UITestingHelper.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 11..
//

#if DEBUG
import Foundation

struct UITestingHelper {
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
    static var isTrendingRepoListViewNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-trendingList-networking-success"] == "1"
    }
    static var isRepoDetailedViewNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-repoDetailedView-networking-success"] == "1"
    }
}
#endif
