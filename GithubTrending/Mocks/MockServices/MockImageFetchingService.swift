//
//  MockImageFetchingService.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 11..
//

#if DEBUG
import Foundation

final class MockImageFetchingService: FileFetchingServiceProtocol, Mockable {
    func asyncDownload<T>(url: URL) async throws -> T? {
        return handleResponse(data: loadAvatarImageSample(), response: .none)
    }
    
    func handleResponse<T>(data: Data?, response: URLResponse?) -> T? {
        return data as? T
    }
}
#endif
