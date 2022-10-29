//
//  FileFetchingServiceProtocol.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 08..
//

import Foundation

protocol FileFetchingServiceProtocol {
    func asyncDownload<T>(url: URL) async throws -> T?
    func handleResponse<T>(data: Data?, response: URLResponse?) -> T?
}
