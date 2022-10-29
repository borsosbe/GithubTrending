//
//  UnderlinedButtonView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 05..
//

import SwiftUI

struct UnderlinedButtonView: View {
    let title: String
    var body: some View {
        Text(title)
            .foregroundColor(Color.theme.underlineButton)
            .underline()
    }
}

struct UnderlinedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UnderlinedButtonView(title: "Privacy Policy")
    }
}
