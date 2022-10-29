//
//  ListUIRefreshControlModifier.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//

import SwiftUI

struct ListUIRefreshControlModifier: ViewModifier {
    private var tintColor: UIColor?
    
    init(tintColor: UIColor?) {
        UIRefreshControl.appearance().tintColor = tintColor ?? .white
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content
    }
}
