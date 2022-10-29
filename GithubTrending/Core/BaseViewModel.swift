//
//  BaseViewModel.swift
//  GithubTrending
//
//  Created by Bence Borsos on 2022. 10. 11..
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    @Published var error: Error?
    var onErrorCompletion: ((Subscribers.Completion<Error>) -> Void)?
    
    init(error: Error? = nil) {
        self.error = nil
        self.onErrorCompletion = { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("🔥 failure: \(error)")
                self.error = error
            }
        }
    }
}
