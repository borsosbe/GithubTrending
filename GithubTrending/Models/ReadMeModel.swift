//
//  ReadMeModel.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//

import Foundation

struct ReadMeModel: Codable {
    let downloadUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case downloadUrl = "download_url"
    }
}
