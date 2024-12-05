//
//  User.swift
//  A4
//
//  Created by Sonja Wong on 5/12/2024.
//

import Foundation

struct User {
    let email: String
    let name: String
    let points: Int
}

extension User {
    static let dummyData = [
        User(email: "hi", name: "a", points: 10),
        User(email: "hg", name: "b", points: 20)
    ].sorted(by: { $0.points > $1.points })
}
