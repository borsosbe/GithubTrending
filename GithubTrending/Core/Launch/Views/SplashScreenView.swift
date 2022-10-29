//
//  SplashScreenView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 08..
//

import SwiftUI

struct SplashScreenView<Content: View, Logo: View, Link: View>: View {
    private let linkText: Binding<String>
    private let content: Content
    private let logoView: Logo
    private let linkView: Link
    private let linkTextKey: LocalizedStringKey = "launch_github_link"
    
    init(linkText: Binding<String>, @ViewBuilder content: @escaping () -> Content, @ViewBuilder logoView: @escaping () -> Logo, @ViewBuilder linkView: @escaping () -> Link) {
        self.content = content()
        self.logoView = logoView()
        self.linkView = linkView()
        self.linkText = linkText
    }

    @State var animating = false
    @State var endAnimation = false
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geo in
                ZStack {
                    Color.theme.background.ignoresSafeArea()
                        .overlay(
                            ZStack{
                                if !endAnimation{
                                    logoView
                                        .matchedGeometryEffect(id: "LOGO", in: animation)
                                        .opacity(animating ? 0 : 1)
                                    linkView
                                        .matchedGeometryEffect(id: "LINK", in: animation)
                                        .font(.system(size: animating ? 16: 40, weight: .bold))
                                        .offset(y: 110)
                                }
                            }
                        )
                        .overlay(
                            VStack {
                                HStack{
                                    Spacer()
                                    if endAnimation {
                                        if #available(iOS 16.0, *) {
                                            // iOS 15 version does not look great with iOS 16
                                            linkView
                                                .matchedGeometryEffect(id: "LINK", in: animation)
                                                .fontWeight(.bold)
                                        } else {
                                            linkView
                                                .matchedGeometryEffect(id: "LINK", in: animation)
                                                .font(.system(size: 16, weight: .bold))
                                        }
                                    }
                                }.padding(.horizontal)
                                Spacer()
                                if endAnimation {
                                    logoView
                                        .matchedGeometryEffect(id: "LOGO", in: animation)
                                        .opacity(0)
                                }
                            }
                        )
                }
                .frame(height: endAnimation ? 60 : nil)
                .zIndex(1)
                content
                    .frame(height: endAnimation ? nil : 0)
                    .zIndex(0)
            }
        }
        .background(Color.theme.background)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.64) {
                withAnimation(.spring()) {
                    animating.toggle()
                }
                withAnimation(
                    Animation.easeIn(duration: 0.8)) {
                    endAnimation.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(
                        Animation.spring()) {
                        self.linkText.wrappedValue = linkTextKey.localized()
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showTrendingList: .constant(false))
    }
}
