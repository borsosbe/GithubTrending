//
//  NetworkingError.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 11..
//

import Foundation

enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
        case .unknown: return "[⚠️] Unknown error occured"
        }
    }
}
