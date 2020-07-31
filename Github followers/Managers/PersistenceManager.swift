//
//  PersistenceManager.swift
//  Github followers
//
//  Created by rs on 31.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import Foundation

enum PersistanceActionType {
    case add
    case remove
}

enum PersistenceManager {
    static let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(ErrorMessage.errorFetchingFavorites))
        }
    }
    
    static func save(favorites: [Follower]) -> ErrorMessage? {
        
        do {
            let encoder = JSONEncoder()
            let favoritesData = try encoder.encode(favorites)
            defaults.set(favoritesData, forKey: Keys.favorites)
        } catch {
            return ErrorMessage.errorSavingFavorites
        }
        
        return nil
    }
    
    static func updateWith(follower: Follower, action: PersistanceActionType, completed: @escaping (ErrorMessage?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var updatedFavorites = favorites
                switch action {
                    
                case .add:
                    guard !updatedFavorites.contains(follower) else {
                        completed(ErrorMessage.userAlreadyFavorite)
                        return
                    }
                    
                    updatedFavorites.append(follower)
                    
                    case .remove:
                        updatedFavorites.removeAll { $0.login == follower.login }

                }
                completed(save(favorites: updatedFavorites))
                
            case .failure(let error):
                completed(error)
            }
            
        }
    }
}
