//
//  RepoDetailView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//

import SwiftUI
import MarkdownView

struct RepoDetailLoadingView: View {
    @Binding var repo: RepoModel?
    
    var body: some View {
        ZStack {
            if let repo = repo {
                RepoDetailView(repo: repo, networkingManager: NetworkingManager(), readMeFetchingService: ReadMeFetchingService())
            }
        }
    }
}

struct RepoDetailView: View {
    @StateObject private var vm: RepoDetailViewModel
    @State var markDownRendered: Bool = false
    private let navTitle: LocalizedStringKey = "repo_detail_nav_title"
    
    init(repo: RepoModel, networkingManager: NetworkingManagerProtocol, readMeFetchingService: FileFetchingServiceProtocol ) {
#if DEBUG
        if UITestingHelper.isUITesting {
            let mockNetworkingManager = MockNetworkingManager()
            let mockReadMeFetchingService = MockReadMeFetchingService()
            if !UITestingHelper.isRepoDetailedViewNetworkingSuccessful {
                mockReadMeFetchingService.mockNetworkFailure = true
            }
            _vm = StateObject(wrappedValue: RepoDetailViewModel(repo: repo, networkingManager: mockNetworkingManager, readMeFetchingService: mockReadMeFetchingService))
        } else {
            _vm = StateObject(wrappedValue: RepoDetailViewModel(repo: repo, networkingManager: networkingManager, readMeFetchingService: readMeFetchingService))
        }
#else
        _vm = StateObject(wrappedValue: RepoDetailViewModel(repo: repo, networkingManager: networkingManager, readMeFetchingService: readMeFetchingService))
#endif
    }
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            ScrollView {
                RepoRowView(repo: vm.repo)
                    .accessibilityIdentifier("repoRow")
                    .navigationTitle(navTitle)
                    .padding(10)
                if (vm.markDownURL != nil) {
                    readMeView
                        .accessibilityIdentifier("readMe")
                }
            }
        }
        .onAppear {
            vm.onViewModelAppear()
        }
    }
}

struct RepoDetailView_Previews: PreviewProvider {
    static let networkingManager = NetworkingManager(networkEnviroment: .dev)
    static let readMeFetchingService = ReadMeFetchingService()
    static var previews: some View {
        NavigationView {
            RepoDetailView(repo: dev.repo, networkingManager: networkingManager, readMeFetchingService: readMeFetchingService)
        }.background(Color.theme.background)
            .modifier(NavigationBarModifier(backgroundColor: UIColor(Color.theme.background), titleColor: UIColor(Color.theme.text)))
    }
}

extension RepoDetailView {
    private var readMeView: some View {
        VStack {
            GroupBox {
                if (!markDownRendered) {
                    LoadingIndicator()
                }
                if (vm.readMeMarkDown != nil) {
                    MarkdownUI(body: vm.readMeMarkDown)
                        .onRendered { _ in
                            if !markDownRendered {
                                markDownRendered.toggle()
                            }
                        }
                        .onTouchLink { link in
                            if let url = link.url {
                                UIApplication.shared.open(url)
                            }
                            return false
                        }
                        .background(Color.theme.lightBackgroundColor)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
        }
        .colorScheme(.light)
    }
}

