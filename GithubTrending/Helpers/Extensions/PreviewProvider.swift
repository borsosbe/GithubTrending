//
//  PreviewProvider.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let repo = RepoModel(id: 0, name: "datasets", owner: OwnerModel(id: 0, name: "huggingface", githubURL: URL(string: "https://github.com/huggingface")!, avatarURL: URL(string: "https://avatars.githubusercontent.com/u/25720743?v=4")!), description: "🤗 The largest hub of ready-to-use datasets for ML models with fast, easy-to-use and efficient data manipulation tools", stargazersCount: 79, subscribersCount: 60, language: "Python")
}
