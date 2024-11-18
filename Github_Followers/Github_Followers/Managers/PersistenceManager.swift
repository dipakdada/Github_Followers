//
//  PersistenceManager.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 22/10/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {

    static private let defaults = UserDefaults.standard

    enum Keys {
        static let favourite = "favourites"
    }

    static func updateWith(favourite:Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void){
        retriveFavourites{ result in
            switch result {
                case .success(var favourites):
                    switch actionType {
                        case .add :
                            guard !favourites.contains(favourite) else {
                                completed(.alreadyToFavourite)
                                return
                            }
                            favourites.append(favourite)
                        case .remove :
                            favourites.removeAll{ $0.login == favourite.login }
                    }
                    completed(save(favourite: favourites))
                case .failure(let error):
                    completed(error)
            }
        }
    }

    static func retriveFavourites(completed: @escaping (Result<[Follower],GFError>) -> Void){
        guard let favouriteData = defaults.object(forKey: Keys.favourite) as? Data else {
            completed(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            // Make sure that the response received parameter and model parameter should mathch
            let favourite = try decoder.decode([Follower].self, from: favouriteData)
            completed(.success(favourite))
        } catch {
            completed(.failure(.unableToFavorite))
        }
        
    }

    static func save(favourite: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodeFavourite = try encoder.encode(favourite)
            defaults.set(encodeFavourite, forKey: Keys.favourite)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
