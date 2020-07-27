//
//  NetworkManager.swift
//  Github followers
//
//  Created by rs on 27.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    private init(){}
    
    func getFollowers(username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseUrl + username + "/followers?page=\(page)&per_page=100"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "Invalid request url.")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {data, response, error in
            if let error = error {
                completed(nil, "Error occured. \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Bad response from server. Try again later.")
                return
            }
            
            guard let data = data else {
                completed(nil, "Invalid data received from server.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "Invalid data received from server.")
            }
        }
        
        task.resume()
        
    }
}
