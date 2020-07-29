//
//  NetworkManager.swift
//  Github followers
//
//  Created by rs on 27.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init(){}
    
    func getFollowers(username: String, page: Int, completed: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
        let endpoint = baseUrl + username + "/followers?page=\(page)&per_page=100"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {data, response, error in
            if let _ = error {
                completed(.failure(.unableToPerformRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(ErrorMessage.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
        
    }
}
