//
//  RepoModel.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 06..
//

import Foundation

struct RepoModel: Identifiable, Codable {
    let id: Int
    let name: String
    let owner: OwnerModel
    let description: String?
    let stargazersCount: Int
    let subscribersCount: Int
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, owner, description, language
        case stargazersCount = "stargazers_count"
        case subscribersCount = "subscribers_count"
    }
}


