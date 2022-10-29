//
//  TrendingRepoListView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 06..
//

import SwiftUI

struct TrendingRepoListView: View {
    @StateObject private var vm: TrendingRepoListViewModel
    @State private var showDetailView: Bool = false
    @State private var selectedRepo: RepoModel? = nil
    private let navTitle: LocalizedStringKey = "trending_repo_list_nav_title"

    init(scraperService: ScraperServiceProtocol, networkingManager: NetworkingManagerProtocol) {
#if DEBUG
        if UITestingHelper.isUITesting {
            let mockTrendingScraperService = MockTrendingScraperService()
            let mockNetworkingManager = MockNetworkingManager()
            if UITestingHelper.isTrendingRepoListViewNetworkingSuccessful {
                mockTrendingScraperService.fillUpscrapedRepoModelsResults()
            } else {
                mockTrendingScraperService.mockNetworkFailure = true
            }
            _vm = StateObject(wrappedValue: TrendingRepoListViewModel(scraperService: mockTrendingScraperService, networkingManager: mockNetworkingManager))
        } else {
            _vm = StateObject(wrappedValue: TrendingRepoListViewModel(scraperService: scraperService, networkingManager: networkingManager))
        }
#else
        _vm = StateObject(wrappedValue: TrendingRepoListViewModel(scraperService: scraperService, networkingManager: networkingManager))
#endif
    }
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                if vm.refreshInProgess {
                    LoadingIndicator()
                        .accessibilityIdentifier("loadingIndicator")
                }
                if !vm.refreshInProgess && !vm.repos.isEmpty {
                    repoList
                        .background(
                            NavigationLink(
                                destination: RepoDetailLoadingView(repo: $selectedRepo),
                                isActive: $showDetailView,
                                label: { EmptyView() }))
                }
            }
        }
        .errorAlert(error: $vm.error)
        .navigationTitle(navTitle)
        .toolbar {
            Button(action: {
                vm.reload()
            }, label: {
                Image(systemName: "goforward")
            })
            .accessibilityIdentifier("refreshButton")
        }
        .onAppear {
            vm.onViewModelAppear()
        }
    }
}

struct TrendingRepoListView_Previews: PreviewProvider {
    static let trendingScraperService = TrendingScraperService()
    static let networkingManager = NetworkingManager(networkEnviroment: .dev)
    
    static var previews: some View {
        NavigationView {
            TrendingRepoListView(scraperService: trendingScraperService, networkingManager: networkingManager)
        }
        .background(Color.theme.background)
        .modifier(NavigationBarModifier(backgroundColor: UIColor(Color.theme.background), titleColor: UIColor(Color.theme.text)))
    }
}

extension TrendingRepoListView {
    private var repoList: some View {
        List {
            ForEach(vm.repos) { repo in
                RepoRowView(repo: repo)
                    .accessibilityIdentifier("item_\(repo.id)")
                    .listRowInsets(
                        .init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.theme.background)
                    .onTapGesture {
                        segue(repo: repo)
                    }
            }
        }
        .accessibilityIdentifier("trendingRepoList")
        .tint(Color.theme.accent)
        .listStyle(.plain)
        .modifier(ListBackgroundModifier())
        .modifier(ListUIRefreshControlModifier(tintColor: UIColor(Color.theme.accent)))
    }
    
    private func segue(repo: RepoModel) {
        selectedRepo = repo
        showDetailView.toggle()
    }
}


