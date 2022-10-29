//
//  ListBackgroundModifier.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//

import SwiftUI

struct ListBackgroundModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

