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
    let pfpURL: String
}

extension User {
    static let dummyData = [
        User(email: "hi", name: "a", points: 10, pfpURL: ""),
        User(email: "hg", name: "b", points: 20,  pfpURL: "")
    ].sorted(by: { $0.points > $1.points })
}
