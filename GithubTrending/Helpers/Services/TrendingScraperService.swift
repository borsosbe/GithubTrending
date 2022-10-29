//
//  ScraperService.swift
//  GithubTrending
//  The scraper package depandancy is not the best, the Repository model properties are inaccessible due to 'internal' protection level but still printable so we slice out the neccassery information from it
//  Created by Bence Borsos on 2022. 10. 06..
//

import Foundation
import GithubTrendingAPI
import Combine

final class TrendingScraperService: ScraperServiceProtocol {
    let slicePartBeginning: String = "https://github.com/"
    let slicePartEnding: String = "), description:"
    let seperator: String = "/"
    
    func scrapData<T>() -> Future<[T], Error> {
        return Future { promise in
            DispatchQueue.global().async { [weak self] in
                let res: [Repository] = GithubTrendingAPI.getRepositories()
                if !res.isEmpty {
                    promise(.success(self?.decodeScrapedData(trendingRepositories: res) as? [T] ?? []))
                } else {
                    promise(.failure(NetworkingError.unknown))
                }
            }
        }
    }
   
    private func decodeScrapedData(trendingRepositories: [Repository]) -> [ScrapedRepoModel] {
        var scrapedRepos: [ScrapedRepoModel] = []
        for trendingRepository in trendingRepositories {
            let scrapedString = "\(trendingRepository)".slice(from: slicePartBeginning, to: slicePartEnding)
            if let scrapedComponents: [String] = scrapedString?.components(separatedBy: seperator) {
                // example: microsoft/PowerToys
                if scrapedComponents.count == 2 {
                    scrapedRepos.append(ScrapedRepoModel(ownerName: scrapedComponents[0], repoName: scrapedComponents[1]))
                }
            }
        }
        return scrapedRepos
    }
}


