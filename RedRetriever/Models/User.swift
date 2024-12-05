//
//  User.swift
//  A4
//
//  Created by Ethan Seiz on 12/4/24.
//

import Foundation

struct User {
    let name: String
    let pfp: String
    let retrievings: [String]
    let points: String
}

extension User {
    static let dummyData = [
        User(
            name: "Ethan Seiz",
            pfp: "ethan_pfp",
            retrievings: ["water bottle", "airpods"],
            points: "10"
        )]
}
