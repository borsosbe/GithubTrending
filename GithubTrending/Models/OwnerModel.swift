//
//  OwnerModel.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 06..
//

import Foundation

struct OwnerModel: Identifiable, Codable {
    let id: Int
    let name: String
    let githubURL: URL
    let avatarURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case githubURL = "html_url"
        case avatarURL = "avatar_url"
    }
}
