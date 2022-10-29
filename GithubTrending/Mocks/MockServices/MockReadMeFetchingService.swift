//
//  MockReadMeFetchingService.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 10..
//

#if DEBUG
import Foundation

final class MockReadMeFetchingService: FileFetchingServiceProtocol, Mockable {
    var mockNetworkFailure: Bool = false
    func asyncDownload<T>(url: URL) async throws -> T? {
        if mockNetworkFailure {
            throw NetworkingError.unknown
        }
        return handleResponse(data: loadReadMeSample(), response: .none)
    }
    
    func handleResponse<T>(data: Data?, response: URLResponse?) -> T? {
        guard
            let data = data,
            let string = String(data: data, encoding: .utf8) as? T else {
                fatalError("Failed to decode .md data to String.")
            }
        return string
    }
}
#endif
