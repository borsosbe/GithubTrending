//
//  ImageFetchingService.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//

import Foundation

final class ImageFetchingService: FileFetchingServiceProtocol {
    func asyncDownload<T>(url: URL) async throws -> T? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
    }
    
    func handleResponse<T>(data: Data?, response: URLResponse?) -> T? {
        guard
            let imgData = data as? T,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                return nil
            }
        return imgData
    }
}
