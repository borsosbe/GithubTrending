//
//  SplashAnimationView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 08..
//

import SwiftUI

struct SplashAnimationView: View {
    @State var linkText = "Github"
    @Binding var showTrendingList: Bool
    private let githubUrl: LocalizedStringKey = "launch_github_url"
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                SplashScreenView(linkText: $linkText) {
                    LaunchView(showTrendingList: $showTrendingList)
                } logoView: {
                    Image("GithubLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 91)
                } linkView: {
                    Link(linkText, destination: URL(string: githubUrl.localized())!)
                        .padding(.top, geo.size.height * 0.04)
                        .foregroundColor(Color.theme.text)
                        .frame(width: 128)
                }
            }
        }
    }
}

struct  SplashAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        SplashAnimationView(showTrendingList: .constant(false))
    }
}
