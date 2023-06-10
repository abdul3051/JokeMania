//
//  JMJokesViewModel.swift
//  JokeMania
//
//  Created by Abdul Rahman Khan on 10/06/23.
//

import Combine
import Foundation

class JMJokesViewModel {
    var jokes: [String] = [] {
        didSet {
            updateUI?()
        }
    }

    private var cancellables: Set<AnyCancellable> = []
    private let networkManager = JMNetworkManager.shared
    private let coreDataStack = JMCoreDataStack.shared

    var updateUI: (() -> Void)?

    init() {
        retrieveStoredJokes()
        startTimer()
        retrieveStoredJokes()
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.fetchJokes()
        }.fire()
    }

    func fetchJokes() {
        networkManager.fetchJoke { [weak self] result in
            switch result {
            case .success(let joke):
                self?.addJoke(joke)
            case .failure(let error):
                print("Failed to fetch joke: \(error)")
            }
        }
    }

    func addJoke(_ joke: String) {
        coreDataStack.saveJoke(joke)
        retrieveStoredJokes()
    }

    private func retrieveStoredJokes() {
        let storedJokes = coreDataStack.fetchJokes(limit: 10)
        jokes = storedJokes.map { $0.text ?? "" }
    }
}
