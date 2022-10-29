//
//  GithubTrendingApp.swift
//  GithubTrendingApp
//
//  Created by Bence Borsos on 2022. 10. 05..
//

import SwiftUI

@main
struct GithubTrendingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var showTrendingList: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if !showTrendingList {
                SplashAnimationView(showTrendingList: $showTrendingList)
                    .preferredColorScheme(.dark)
            } else {
                NavigationView {
                    TrendingRepoListView(scraperService: TrendingScraperService(), networkingManager: NetworkingManager())
                }
                .background(Color.theme.background)
                .modifier(NavigationBarModifier(backgroundColor: UIColor(Color.theme.background), titleColor: UIColor(Color.theme.text)))
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
                .navigationViewStyle(.stack)
            }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        print("👷🏾‍♂️ Is UI Test Running: \(UITestingHelper.isUITesting)")
        #endif
        return true
    }
}
