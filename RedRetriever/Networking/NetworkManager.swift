//
//  NetworkManager.swift
//  A4
//
//  Created by Ethan Seiz on 12/5/24.
//

import Foundation
import Alamofire

class NetworkManager {

    /// Shared singleton instance
    static let shared = NetworkManager()

    private init() { }

    /// Endpoint for dev server
    func fetchAllPosts(completion: @escaping ([Post]) -> Void) {
        
        let devEndpoint: String = "https://chatdev-wuzwgwv35a-ue.a.run.app/api/posts/"
        
        // Create a decoder
        let decoder = JSONDecoder()
        
        // decode date strings
        decoder.dateDecodingStrategy = .iso8601
        // convert keys to camel case
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // MARK: - Requests
        
        AF.request(devEndpoint, method: .get)
            .validate()
            .responseDecodable(of: [Post].self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let posts):
                    print("Successfully fetched \(posts.count) posts")
                    completion(posts)
                case .failure(let error):
                    print("Error in NetworkManager.fetchRoster: \(error.localizedDescription)")
                }
            }
    }
    
    /**
     Add a new post

     - Parameters:
        - member: the member object to add
     */
//    func createPost(post: Post, completion: @escaping (Post) -> Void) {
//        // Specify the endpoint
//        let devEndpoint: String = "https://chatdev-wuzwgwv35a-ue.a.run.app/api/posts/"
//
//        // Define the request body
//        let parameters: Parameters = [
//            "message": "Ethan Test"
//        ]
//
//        // Create a decoder
//        let decoder = JSONDecoder()
//        // decoder.dateDecodingStrategy = .iso8601 // Only if needed
//        // decoder.keyDecodingStrategy = .convertFromSnakeCase // Only if needed
//
//        // Create the request
//        AF.request(devEndpoint, method: .post, parameters: parameters)
//            .validate()
//            .responseDecodable(of: Post.self, decoder: decoder) { response in
//                // Handle the response
//                switch response.result {
//                case .success(let post):
//                    print("Successfully added member \(post.message)")
//                    completion(post)
//                case .failure(let error):
//                    print("Error in NetworkManager.addToRoster: \(error.localizedDescription)")
//                }
//            }
//    }
}
