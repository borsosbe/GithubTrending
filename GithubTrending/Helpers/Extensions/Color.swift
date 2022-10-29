//
//  Color.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 05..
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let secondary = Color("SecondaryColor")
    let background = Color("BackgroundColor")
    let text = Color("TextColor")
    let underlineButton = Color("UnderlineTextButtonColor")
    let lightBackgroundColor = Color("LightBackgroundColor")
}
