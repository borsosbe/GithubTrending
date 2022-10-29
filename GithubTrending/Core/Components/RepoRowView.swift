//
//  RepoRowView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 06..
//

import SwiftUI

struct RepoRowView: View {
    let repo: RepoModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                HStack {
                    RepoAvatarImageView(imageFetchingService: ImageFetchingService(), url: repo.owner.avatarURL, width: 50, height: 50)
                    VStack(alignment: .leading) {
                        BodyTextView(text: repo.owner.name)
                        BodyTextView(text: repo.name, fontWeight: .bold, textColor: Color.theme.accent)
                    }
                    Spacer()
                }
                if (!(repo.description?.isEmpty ?? true)) {
                    BodyTextView(text: repo.description ?? "")
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                HStack {
                    HStack {
                        Image(systemName: "star")
                            .foregroundColor(Color.theme.text)
                        BodyTextView(text: String(repo.stargazersCount))
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    HStack {
                        Image(systemName: "eye")
                            .foregroundColor(Color.theme.text)
                        BodyTextView(text: String(repo.subscribersCount))
                        BodyTextView(text: repo.language ?? "", textColor: Color.theme.accent)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
            .padding(10)
        }
        .background(Color.theme.secondary)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.clear, lineWidth: 0)
        )
        .dynamicTypeSize(.small ... .xLarge)
    }
}

struct RepoRowView_Previews: PreviewProvider {
    static var previews: some View {
        RepoRowView(repo: dev.repo)
    }
}
