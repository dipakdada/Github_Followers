//
//  NetworkManager.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 08/10/24.
//

import UIKit

class NetworkManager {
    // Create a object usign static keyword, so that you don't have to create the object to access the data of NetworkManager
    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/users/" // base url of github open api
    let paginationCount = 100
    let cache           = NSCache<NSString, UIImage>() // To avoid downloading the image again and again we will store that image into cache memory by using NSCache class of next step

    private init(){}

    // Get all the github followers
    // I have used the Result enum to return sucess or failure
    func getFollowers(for username:String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endPoints = baseURL + "\(username)/followers?per_page=\(paginationCount)&page=\(page)"

        guard let url = URL(string: endPoints) else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in

            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                // create a object of jsonDecoder to decode the data received from the api
                let decoder = JSONDecoder()
                // To maintain the consitantacy in code, if the response parameter received are in snake then convert it to the Camel case
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                // Make sure that the response received parameter and model parameter should mathch
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        // We have different action in URLSession to perform, task.resume() to start the network call
        task.resume()
    }
    
    // Get the information of particular user by using username
    func getUserInfo(for username:String, completed: @escaping (Result<User, GFError>) -> Void){
        let endPoints = baseURL + "\(username)"

        guard let url = URL(string: endPoints) else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in

            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder                     = JSONDecoder()
                // To maintain the consitantacy in code, if the response parameter received are in snake then convert it to the Camel case
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                // If we use the dateDecodingStrategy then we don't need to convert the string to date and then date to string, we get the date directly
                decoder.dateDecodingStrategy    = .iso8601
                // Make sure that the response received parameter and model parameter should mathch
                let user                        = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }

    // download image api if not present in the cache memory 
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void){
        let cacheKey = NSString(string: urlString) // We need to convert the string into NSString
        // Check if the image is present in the cache memory, if present then apply that image and return from there itself else download that image
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        guard let url = URL(string: urlString) else { 
            completed(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            // insert image into cahe memory after download we can use setObject function
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }

        task.resume()
    }
}
