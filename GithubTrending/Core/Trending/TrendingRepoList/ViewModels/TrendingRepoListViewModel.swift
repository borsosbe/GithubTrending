//
//  TrendingRepoListViewModel.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 06..
//

import Foundation
import Combine
import GithubTrendingAPI

final class TrendingRepoListViewModel: BaseViewModel {
    @Published private(set) var repos: [RepoModel] = []
    @Published private(set) var refreshInProgess: Bool = false
    private let scraperService: ScraperServiceProtocol
    private let networkingManager: NetworkingManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(scraperService: ScraperServiceProtocol, networkingManager: NetworkingManagerProtocol) {
        self.scraperService = scraperService
        self.networkingManager = networkingManager
        super.init(error: nil)
        self.onErrorCompletion = { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("🔥 failure: \(error)")
                DispatchQueue.main.async { [weak self] in
                    self?.refreshInProgess = false
                    self?.error = error
                }
            }
        }
    }
    
    func onViewModelAppear() {
        if !refreshInProgess && repos.isEmpty {
            loadScrapedData()
        }
    }
    
    func reload() {
        HapticManager.notification(type: .success)
        if !refreshInProgess {
            loadScrapedData()
        }
    }
    
    private func loadScrapedData() {
        refreshInProgess.toggle()
        scraperService.scrapData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: onErrorCompletion!, receiveValue: { [weak self] result in
                self?.downloadRepos(scrapedRepos: result)
            })
            .store(in: &cancellables)
    }
    
    private func downloadRepos(scrapedRepos: [ScrapedRepoModel]?) {
        guard scrapedRepos != nil else {
            return
        }
        var count = 0
        var tempRepos: [RepoModel] = []
        for scrapedRepo in scrapedRepos! {
            networkingManager.download(type: EndpointItem.getRepo(scrapedRepo.ownerName, scrapedRepo.repoName))
                .decode(type: RepoModel.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: onErrorCompletion!, receiveValue: { [weak self] (returnedRepo) in
                    tempRepos.append(returnedRepo)
                    count += 1
                    if count == scrapedRepos!.count {
                        self?.repos = tempRepos
                        self?.refreshInProgess.toggle()
                    }
                })
                .store(in: &cancellables)
        }
    }
}


