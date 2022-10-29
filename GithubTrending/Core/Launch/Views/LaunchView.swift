//
//  LaunchView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 05..
//

import SwiftUI

struct LaunchView: View {
    @State private var showWebView = false
    @Binding var showTrendingList: Bool
    private let linkText: LocalizedStringKey = "launch_github_link"
    private let title: LocalizedStringKey = "launch_welcome"
    private let info: LocalizedStringKey = "launch_info"
    private let desc: LocalizedStringKey = "launch_desc"
    private let buttonText: LocalizedStringKey = "launch_enter_button"
    private let pp: LocalizedStringKey = "launch_pp"
    private let terms: LocalizedStringKey = "launch_terms"
    private let and: LocalizedStringKey = "and"
    private let githubUrl: LocalizedStringKey = "launch_github_url"
    private let githubPpUrl: LocalizedStringKey = "launch_github_pp_url"
    private let githubTermsUrl: LocalizedStringKey = "launch_github_terms_url"
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            GeometryReader { geo in
                VStack (alignment: .center) {
                    launchHeader
                    Spacer()
                    launchBodyImage
                        .frame(height: geo.size.width * 0.34)
                    launchBodyText
                        .frame(width: geo.size.width * 0.9)
                        .transaction { transaction in
                            transaction.animation = nil
                        }
                    Spacer()
                    launchFooterButton
                        .frame(width: geo.size.width * 0.7)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: geo.size.height * 0.04, trailing: 0))
                    launchFooterTextButtons
                        .frame(width: geo.size.width * 0.9)
                }.dynamicTypeSize(.small ... .xLarge)
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showTrendingList: .constant(false))
    }
}

extension LaunchView {
    private var launchHeader: some View {
        HStack {
            Spacer()
            ZStack {
                Link(linkText, destination: URL(string: githubUrl.localized())!)
                    .font(.system(size: 16, weight: .bold))
                    .padding(.top, 5)
            }.fixedSize(horizontal: true, vertical: true)
                .foregroundColor(Color.theme.text)
                .padding()
        }
    }
    
    private var launchBodyImage: some View {
        Image("GithubLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(10)
    }
    
    private var launchBodyText: some View {
        VStack {
            LargeTitleTextView(text: title.localized())
                .allowsTightening(true)
                .multilineTextAlignment(.center)
                .padding(10)
            BodyTextView(text: info.localized())
            BodyTextView(text: desc.localized())
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
                .multilineTextAlignment(.center)
        }
    }
    
    private var launchFooterButton: some View {
        VStack {
            Button(action: {
                showTrendingList.toggle()
            }, label: {
                RoundedButtonView(title: buttonText.localized())
                    .accessibilityIdentifier("enterButton")
            })
        }
    }
    
    private var launchFooterTextButtons: some View {
        VStack {
            HStack(alignment: .center, spacing: 4, content: {
                Spacer()
                Button(action: {
                    showWebView.toggle()
                }, label: {
                    UnderlinedButtonView(title: pp.localized())
                }).sheet(isPresented: $showWebView) {
                    WebView(url: URL(string: githubPpUrl.localized())!)
                }
                Text(and)
                    .foregroundColor(Color.theme.underlineButton)
                Button(action: {
                    showWebView.toggle()
                }, label: {
                    UnderlinedButtonView(title: terms.localized())
                }).sheet(isPresented: $showWebView) {
                    WebView(url: URL(string: githubTermsUrl.localized())!)
                }
                Spacer()
            })
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
        }
    }
}
