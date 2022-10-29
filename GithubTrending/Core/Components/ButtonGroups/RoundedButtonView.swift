//
//  RoundedButtonView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 05..
//

import SwiftUI

struct RoundedButtonView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.theme.accent)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct RoundedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButtonView(title: "Round Me")
                .previewLayout(.sizeThatFits)
    }
}
