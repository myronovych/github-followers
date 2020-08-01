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
    
    func getUser(username: String, completed: @escaping (Result<User, ErrorMessage>) -> Void) {
        let endpoint = baseUrl + username
        
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
                decoder.dateDecodingStrategy = .iso8601
                let follower = try decoder.decode(User.self, from: data)
                completed(.success(follower))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        if let image = NetworkManager.shared.cache.object(forKey: NSString(string: urlString)) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: NSString(string: urlString))
            
            DispatchQueue.main.async {
                completed(image)
            }
        }
        
        task.resume()
    }
}
