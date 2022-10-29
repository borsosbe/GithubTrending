//
//  HapticManager.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 07..
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
