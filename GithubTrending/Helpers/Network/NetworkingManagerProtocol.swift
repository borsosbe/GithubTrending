//
//  NetworkingManagerProtocol.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 12..
//

import Foundation
import Combine

protocol NetworkingManagerProtocol {
    static var networkEnviroment: NetworkEnvironment { get }
    func download(type: EndPointType) -> AnyPublisher<Data, Error>
    func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data
    func handleCompletion(completion: Subscribers.Completion<Error>)
}
