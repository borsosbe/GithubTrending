//
//  ScraperServiceProtocol.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 08..
//

import Foundation
import Combine

protocol ScraperServiceProtocol {
    func scrapData<T>() -> Future<[T], Error>
}
