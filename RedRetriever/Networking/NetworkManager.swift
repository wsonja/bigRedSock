//
//  NetworkManager.swift
//  A4
//
//  Created by Sonja Wong on 6/12/2024.
//

  
import Alamofire
import Foundation
import UIKit

class NetworkManager {

    /// Shared singleton instance
    static let shared = NetworkManager()

    private init() { }

    /// Endpoint for dev server
    private let devEndpoint: String = "http://35.221.24.216/api/"

    // MARK: - Requests
    
    func fetchAllPosts(completion: @escaping ([Request]) -> Void){
        print("fetchAllPosts called in NetworkManager")
        let url = "http://35.221.24.216/api/requests/"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print("hi")
        AF.request(url, method: .get).validate().responseDecodable(of: RequestResponse.self) { response in
            switch response.result {
            case .success(let requestResponse):
                // Access the requests array
                let requests = requestResponse.requests
//                print("Fetched Requests: \(requests)")
                completion(requests)
            case .failure(let error):
                print("Error fetching feed: \(error)")
            }
            print("bye")
        }
    }
    
    func fetchAllItems(completion: @escaping ([Item]) -> Void){
        print("fetchAllItems called in NetworkManager")
        let url = "http://35.221.24.216/api/items/"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print("hi")
        AF.request(url, method: .get).validate().responseDecodable(of: ItemResponse.self) { response in
            switch response.result {
            case .success(let itemResponse):
                // Access the requests array
                let items = itemResponse.items
                
//                print("Fetched Items: \(items)")
                completion(items)
            case .failure(let error):
                print("Error fetching feed: \(error)")
            }
            print("bye")
        }
    }
        
        func fetchAllUsers(completion: @escaping ([User]) -> Void){
            print("fetchAllUserscalled in NetworkManager")
            let url = "http://35.221.24.216/api/users/"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            AF.request(url, method: .get).validate().responseDecodable(of: UserResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let userResponse):
                    var users = userResponse.users
                    users = users.sorted(by: { $0.points > $1.points })
//                    print("Fetched Users: \(users)")
                    print("completed")
                    completion(users) // Pass the decoded posts to the completion handler
                case .failure(let error):
                    print("Error fetching feed:", error)
                    completion([]) // Pass an empty array if there's an error
                }
            }
        }
        
        
        
    func createPost(name: String, date:Double, location:String, description: String, phone: String, completion: @escaping (Bool) -> Void) {
            // Specify the endpoint
            let url = "http://35.221.24.216/api/requests/"
            
            // Define the request body
            let parameters: Parameters = [
                "name": name,
                "status":"unclaimed",
                "user_id": UserManager.shared.userID ?? 1,
                "description": description,
                "last_location": location,
                "email": UserManager.shared.email ?? "invalid",
                "phone": phone,
                "date": date
            ]
            
            // Create the request
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .validate()
                .response { response in
                    // Handle the response
                    switch response.result {
                    case .success:
                        print("Post created successfully")
                        completion(true)
                    case .failure(let error):
                        print("Failed to create post:", error)
                        completion(false)
                    }
                    
                }
        }
        
        
        
    func createFound(name: String, date:Double, location:String, description: String, image: String, phone: String, completion: @escaping (Bool) -> Void) {
            // Specify the endpoint
            let url = "http://35.221.24.216/api/items"
    
            // Define the request body
            var parameters: Parameters = [
                "title": name,
                "description": description,
                "status": "not found",
                "location": location,
                "finder_id": UserManager.shared.userID ?? 1,
                "email": UserManager.shared.email ?? "invalid",
                "phone": phone,
                "date": date,
                "image": image,

            ]

            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .validate()
                .response { response in
                    // Handle the response
                    switch response.result {
                    case .success:
                        print("Post created successfully")
                    case .failure(let error):
                        print("Failed to create post:", error)
                    }
                }
        print("hihi")
        parameters = [
            "points": (UserManager.shared.points ?? 0)+5
        ]
        
        AF.request("http://35.221.24.216/api/users/\(UserManager.shared.userID ?? 1)", method: .put, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .response { response in
                // Handle the response
                switch response.result {
                case .success:
                    print("Points updated successfully")
                    completion(true)
                case .failure(let error):
                    print("Failed to update points:", error)
                    completion(false)
                }
                
            }
            
        }
        
        
        
    func successMatch(postID: Int, requestID: Int, completion: @escaping (Bool) -> Void) {
            let url = "http://35.221.24.216/api/requests/\(requestID)/items/\(postID)"
            
            // find out which request has this item in the similar items list
            // verify that that request's user is current user
            // get the request id
            // then post http://35.221.24.216/api/requests/1/items/1
            // put simialr items = []

            AF.request(url, method: .post, encoding: JSONEncoding.default)
                .validate()
                .response { response in
                    switch response.result {
                    case .success:
                        print("Item matched successfully")
                        completion(true)
                    case .failure(let error):
                        print("Failed to match item:", error)
                        completion(false)
                    }
                }
        }
        
        func unsuccessMatch(postID: String, completion: @escaping (Bool) -> Void) {
            let url = "http://chatdev-wuzwgwv35a-ue.a.run.app/api/posts/like/"
            
            let parameters: Parameters = [
                "post_id": postID,
                "status": "pending"
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .validate()
                .response { response in
                    switch response.result {
                    case .success:
                        print("Item is now pending")
                        completion(true)
                    case .failure(let error):
                        print("Failed to repost pending item.", error)
                        completion(false)
                    }
                }
        }
        
        func rescind(postID: Int,completion: @escaping (Bool) -> Void){
            let url = "http://35.221.24.216/api/requests/\(postID)"
            
       
            AF.request(url, method: .delete, encoding: URLEncoding.default).validate().response { response in
                switch response.result {
                case .success:
                    print("Resource deleted successfully.")
                    completion(true)
                case .failure(let error):
                    print("Failed to delete resource: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
        
    }


