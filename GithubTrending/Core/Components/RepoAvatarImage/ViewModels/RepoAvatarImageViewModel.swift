//
//  RepoAvatarImageViewModel.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//
//
import Foundation
import Combine

final class RepoAvatarImageViewModel: ObservableObject {
    @Published private(set) var imageData: Data? = nil
    @Published private(set) var isLoading: Bool = false
    private let imageFetchingService: FileFetchingServiceProtocol
    private let url: URL?

    init(url: URL?, imageFetchingService: FileFetchingServiceProtocol) {
        self.imageFetchingService = imageFetchingService
        self.url = url
    }
    
    func fetchImage() async {
        DispatchQueue.main.async {
            self.isLoading.toggle()
        }
        if let url = url {
            let data: Data? = try? await imageFetchingService.asyncDownload(url: url)
            await MainActor.run {
                self.imageData = data
                self.isLoading.toggle()
            }
        } else {
            print("Bad url")
        }
    }
}
