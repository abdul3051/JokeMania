//
//  JMNetworkManager.swift
//  JokeMania
//
//  Created by Abdul Rahman Khan on 10/06/23.
//

import Foundation

import Foundation
import Combine

class JMNetworkManager {
    static let shared = JMNetworkManager()
    private let apiUrl = "https://geek-jokes.sameerkumar.website/api"
    private init() {}

    func fetchJoke(completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: self.apiUrl) else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.invalidUrl))
                }
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                if let joke = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        completion(.success(joke))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.invalidData))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}


enum NetworkError: Error {
    case invalidUrl
    case invalidData
}
