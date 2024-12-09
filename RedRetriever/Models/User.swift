//
//  User.swift
//  A4
//
//  Created by Sonja Wong on 5/12/2024.
//

import Foundation

struct UserResponse: Codable {
    let users: [User]
}

struct User: Codable {
    let id: Int              // The user's unique ID
    let name: String         // The user's name
    let email: String        // The user's email address
    let points: Int          // The user's points (e.g., for a reward system)
    let pfpURL: String?      // Optional profile picture URL
    let requests: [Request]      // References to the user's request IDs
}

extension User {
    static let dummyData = [
        User(id: 1, name: "a", email: "sw2374@cornell.edu", points: 10, pfpURL: "", requests: []),
        User(id: 2, name: "b", email: "hi", points: 0, pfpURL: "", requests: []),
    ].sorted(by: { $0.points > $1.points })
}
