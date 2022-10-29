//
//  RepoDetailViewModel.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//

import Foundation
import Combine

final class RepoDetailViewModel: BaseViewModel {
    @Published private(set) var repo: RepoModel
    @Published private(set) var readMeMarkDown: String?
    @Published private(set) var markDownURL: URL?
    private let networkingManager: NetworkingManagerProtocol
    private let readMeFetchingService: FileFetchingServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(repo: RepoModel, networkingManager: NetworkingManagerProtocol, readMeFetchingService: FileFetchingServiceProtocol) {
        self.repo = repo
        self.networkingManager = networkingManager
        self.readMeFetchingService = readMeFetchingService
        super.init(error: nil)
    }
    
    func onViewModelAppear() {
        downloadRepoReadMe()
        $markDownURL
            .receive(on: DispatchQueue.main)
            .sink { value in
                Task { [weak self] in
                    await self?.getReadMeContentFromURL(markDownURL: value)
                }
            }
            .store(in: &cancellables)
    }
    
    private func downloadRepoReadMe() {
        networkingManager.download(type: EndpointItem.getRepoReadMe(repo.owner.name, repo.name))
            .decode(type: ReadMeModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: networkingManager.handleCompletion, receiveValue: { [weak self] (returnedReadMe) in
                self?.markDownURL = returnedReadMe.downloadUrl
            })
            .store(in: &cancellables)
    }
    
    private func getReadMeContentFromURL(markDownURL: URL?) async {
        guard let readMeUrl = markDownURL else { return }
        let string: String? = try? await readMeFetchingService.asyncDownload(url: readMeUrl)
        await MainActor.run {
            if let str = string {
                self.readMeMarkDown = str
            } else {
                self.markDownURL = nil
            }
        }
    }
}
