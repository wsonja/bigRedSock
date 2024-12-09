//
//  Post.swift
//  RedRetriever
//
//  Created by Ethan Seiz on 12/1/24.
//

import Foundation

struct Post: Equatable, Decodable{
    // CHANGE MODEL
    let id: String
    // let user_id: Int
    let description: String
    let image: String
    // let name: String
    let title: String
    let status: String
    // let last_location: String
    let location: String
    let date: Float
    let email: String
    let phone: String
    
    static func ==(lhs: Post, rhs: Post) -> Bool {
            return lhs.id == rhs.id // or any other property you want to compare
        }
}

struct RequestResponse: Codable {
    let requests: [Request]
}

struct Request: Codable {
    let id: Int
    let user_id: Int?
    let status: String
    let name: String
    let location: String?
    let description: String
    let items: [miniItem]
    let email: String
    let phone: String
    let date: Double
    let similar_items: [Int]?
}


struct miniItem: Codable {
    let id: Int
    let title: String
    let status: String
    let description: String // Replace with actual keys and types in the dictionary
    let location: String
    let email: String
    let phone: String
    let date: Double
}

struct miniRequest: Codable{
    let id: Int
    let name: String
    let status: String
    let last_location: String?
    let email: String
    let phone: String
    let date: Double
}

//extension Post {
//    static let dummyData = [
//        Post(
//            id: "801343ed-fc1b-4ed0-a226-2381f0ec4186",
//            description: "Red water bottle with some marks on the side and an 'I Vote' sticker. ",
//            image: "appdev_logo",
//            title: "Water bottle",
//            location: "Gates Hall",
//            time: "12",
//            date: Date(timeIntervalSince1970: 1713585103),
//            status: "not found",
//            email: "sonja.hinting@gmail.com",
//            phone: "1234567890"
//        ),
//        Post(
//            id: "801343ed-fc1b-4ed0-a226-2381f0ec4186",
//            description: "Red water bottle with some marks on the side and an 'I Vote' sticker. ",
//            image: "appdev_logo",
//            title: "Water bottle",
//            location: "Gates Hall",
//            time: "12",
//            date: Date(timeIntervalSince1970: 1713585103),
//            status: "pending",
//            email: "sonja.hinting@gmail.com",
//            phone: "1234567890"
//        ),
//        Post(
//            id: "801343ed-fc1b-4ed0-a226-2381f0ec4186",
//            description: "Red water bottle with some marks on the side and an 'I Vote' sticker. ",
//            image: "appdev_logo",
//            title: "Water bottle",
//            location: "Gates Hall",
//            time: "12",
//            date: Date(timeIntervalSince1970: 1713585103),
//            status: "matched",
//            email: "sonja.hinting@gmail.com",
//            phone: "1234567890"
//        ),
//        Post(
//            id: "801343ed-fc1b-4ed0-a226-2381f0ec4186",
//            description: "Red water bottle with some marks on the side and an 'I Vote' sticker. ",
//            image: "appdev_logo",
//            title: "Water bottle",
//            location: "Gates Hall",
//            time: "12",
//            date: Date(timeIntervalSince1970: 1713585103),
//            status: "found",
//            email: "sonja.hinting@gmail.com",
//            phone: "1234567890"
//        ),
//    ]
    
    
// }
