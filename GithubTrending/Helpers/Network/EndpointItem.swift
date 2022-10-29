//
//  EndpointItem.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 06..
//

import Foundation

enum EndpointItem {
    case getRepo(_: String, _: String)
    case getRepoReadMe(_: String, _: String)
    
    func value() -> Any? {
        switch self {
        case .getRepo(let str1, let str2):
            return [str1, str2]
        case .getRepoReadMe(let str1, let str2):
            return [str1, str2]
        }
    }
}

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var url: URL { get }
}

extension EndpointItem: EndPointType {
    var baseURL: String {
        switch NetworkingManager.networkEnviroment {
        case .dev: return "https://api.github.com/"
        case .production: return "https://api.github.com/"
        }
    }
    
    var path: String {
        switch self {
        case .getRepo(let ownerName, let repoName):
            return "repos/\(ownerName)/\(repoName)"
        case .getRepoReadMe(let ownerName, let repoName):
            return "repos/\(ownerName)/\(repoName)/contents/README.md"
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
}
