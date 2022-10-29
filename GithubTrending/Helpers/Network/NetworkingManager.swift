//
//  NetworkingManager.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 06..
//

import Foundation
import Combine

class NetworkingManager: NetworkingManagerProtocol {
    static var networkEnviroment: NetworkEnvironment = .dev
    
    // for testing
    init(networkEnviroment: NetworkEnvironment? = nil) {
        NetworkingManager.networkEnviroment = networkEnviroment ?? .dev
    }
    
    func download(type: EndPointType) -> AnyPublisher<Data, Error> {
        var urlRequest = URLRequest(url: type.url)
        let token = "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"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ [weak self] in
                try self?.handleURLResponse(output: $0, url: type.url) ?? Data()
            })
            .retry(1)
            .eraseToAnyPublisher()
    }
    
    func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
