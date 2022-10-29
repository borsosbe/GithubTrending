//
//  BodyTextView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//

import SwiftUI

struct BodyTextView: View {
    let text: String
    var fontWeight: Font.Weight = .regular
    var textColor: Color = Color.theme.text
    
    var body: some View {
        Text(text)
            .font(.body)
            .fontWeight(fontWeight)
            .foregroundColor(textColor)
    }
}

struct BodyTextView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            LargeTitleTextView(text: "Github Trending")
        }
    }
}
