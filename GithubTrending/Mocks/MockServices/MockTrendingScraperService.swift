//
//  MockTrendingScraperService.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 10..
//

#if DEBUG
import Combine
import Foundation

final class MockTrendingScraperService: ScraperServiceProtocol {
    var scrapedRepoModelsResults: [ScrapedRepoModel] = []
    var mockNetworkFailure: Bool = false
    
    func scrapData<T>() -> Future<[T], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                if self?.mockNetworkFailure ?? false {
                    promise(.failure(NetworkingError.unknown))
                } else {
                    promise(.success(self?.scrapedRepoModelsResults as? [T] ?? []))
                }
            }
        }
    }
    
    func fillUpscrapedRepoModelsResults() {
        let firstItem = ScrapedRepoModel(ownerName: "huggingface", repoName: "datasets")
        let lastItem = ScrapedRepoModel(ownerName: "ashawkey", repoName: "stable-dreamfusion")
        for _ in 1...5 {
            scrapedRepoModelsResults.append(firstItem)
        }
        scrapedRepoModelsResults.append(lastItem)
    }
}
#endif
