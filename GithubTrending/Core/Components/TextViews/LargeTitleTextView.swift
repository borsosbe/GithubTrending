//
//  LargeTitleTextView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//

import SwiftUI

struct LargeTitleTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color.theme.text)
    }
}

struct LargeTitleTextView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            LargeTitleTextView(text: "Github Trending")
        }
    }
}

