//
//  MockNetworkingManager.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 10..
//

#if DEBUG
import Foundation
import Combine

final class MockNetworkingManager: NetworkingManagerProtocol, Mockable {
    static var networkEnviroment: NetworkEnvironment = .dev
    var responseData: Data?
    
    init(networkEnviroment: NetworkEnvironment? = nil) {
        NetworkingManager.networkEnviroment = networkEnviroment ?? .dev
    }
    
    func download(type: EndPointType) -> AnyPublisher<Data, Error> {
        let repoData = loadJSONDataForEndpoint(endpoint: type as! EndpointItem)
        return CurrentValueSubject(responseData != nil ? responseData! : repoData)
            .eraseToAnyPublisher()
    }
    
    func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        return Data()
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
#endif
