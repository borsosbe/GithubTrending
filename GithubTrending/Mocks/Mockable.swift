//
//  Mockable.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 10..
//

#if DEBUG
import Foundation

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSONDataForEndpoint(endpoint: EndpointItem) -> Data
    func loadReadMeSample() -> Data?
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    private func jsonForEndpoint(endpoint: EndpointItem) -> String {
        switch endpoint {
        case .getRepo(_, _):
            let strings = endpoint.value() as? [String] ?? []
            return "RepoResponse_\(strings[0])_\(strings[1])"
        case .getRepoReadMe:
            return "RepoReadMeResponse"
        }
    }
    
    func loadJSONDataForEndpoint(endpoint: EndpointItem) -> Data {
        guard let path = bundle.url(forResource: jsonForEndpoint(endpoint: endpoint), withExtension: "json") else {
            fatalError("❌ Failed to load JSON file: RepoResponse_\(endpoint).")
        }
        do {
            let data = try Data(contentsOf: path)
            return data
        } catch {
            print("❌ \(error)")
            fatalError("Failed to convert json file to Data with endpoint: \(endpoint).")
        }
    }
    
    func loadReadMeSample() -> Data? {
        guard let path = bundle.url(forResource: "ResponseReadMeSample", withExtension: "md") else {
            fatalError("❌ Failed to load .md file.")
        }
        do {
            let data = try Data(contentsOf: path)
            return data
        } catch {
            print("❌ \(error)")
            fatalError("❌ Failed to convert .md file to Data.")
        }
    }
    
    func loadAvatarImageSample() -> Data? {
        guard let path = bundle.url(forResource: "ResponseAvatarImageSample", withExtension: "png") else {
            fatalError("❌ Failed to load .png file.")
        }
        do {
            let data = try Data(contentsOf: path)
            return data
        } catch {
            print("❌ \(error)")
            fatalError("❌ Failed to convert .png file to Data.")
        }
    }
}
#endif
