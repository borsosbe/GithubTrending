//
//  WebView.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 05..
//

import SwiftUI
import SafariServices

struct WebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<WebView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<WebView>) {
    }

}
