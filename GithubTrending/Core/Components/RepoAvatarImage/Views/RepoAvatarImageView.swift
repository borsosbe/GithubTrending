//
//  RepoAvatarImageView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//

import SwiftUI

struct RepoAvatarImageView: View {
    @StateObject private var vm: RepoAvatarImageViewModel
    let width: CGFloat
    let height: CGFloat
    init(imageFetchingService: FileFetchingServiceProtocol, url: URL?, width: CGFloat, height: CGFloat) {
        _vm = StateObject(wrappedValue: RepoAvatarImageViewModel(url: url, imageFetchingService: imageFetchingService))
        self.width = width
        self.height = height
    }

    var body: some View {
        ZStack {
            if let imageData = vm.imageData {
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
            } else if vm.isLoading {
                LoadingIndicator()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.accent)
            }
        }
        .onAppear {
            Task {
                await vm.fetchImage()
            }
        }
    }
}

struct RepoAvatarImageView_Previews: PreviewProvider {
    static let imageFetchingService = ImageFetchingService()
    static let url = URL(string: "https://avatars.githubusercontent.com/u/25720743?v=4")
    
    static var previews: some View {
        RepoAvatarImageView(imageFetchingService: imageFetchingService, url: url, width: 50, height: 50)
    }
}
