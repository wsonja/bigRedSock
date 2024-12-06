//
//  Post.swift
//  RedRetriever
//
//  Created by Ethan Seiz on 12/1/24.
//

import Foundation

struct Post {
    let id: String
    let description: String
    let image: String
    let title: String
    let location: String
    let time: String
    let date: Date
    let status: String
    let email: String
    let phone: String
}

extension Post {
    static let dummyData = [
        Post(
            id: "801343ed-fc1b-4ed0-a226-2381f0ec4186",
            description: "Red water bottle with some marks on the side and an 'I Vote' sticker. ",
            image: "appdev_logo",
            title: "Water bottle",
            location: "Gates Hall",
            time: "12",
            date: Date(timeIntervalSince1970: 1713585103),
            status: "not found",
            email: "sonja.hinting@gmail.com",
            phone: "1234567890"
        ),
        Post(
            id: "801343ed-fc1b-4ed0-a226-2381f0ec4186",
            description: "Red water bottle with some marks on the side and an 'I Vote' sticker. ",
            image: "appdev_logo",
            title: "Water bottle",
            location: "Gates Hall",
            time: "12",
            date: Date(timeIntervalSince1970: 1713585103),
            status: "pending",
            email: "sonja.hinting@gmail.com",
            phone: "1234567890"
        ),
        Post(
            id: "801343ed-fc1b-4ed0-a226-2381f0ec4186",
            description: "Red water bottle with some marks on the side and an 'I Vote' sticker. ",
            image: "appdev_logo",
            title: "Water bottle",
            location: "Gates Hall",
            time: "12",
            date: Date(timeIntervalSince1970: 1713585103),
            status: "matched",
            email: "sonja.hinting@gmail.com",
            phone: "1234567890"
        ),
        Post(
            id: "801343ed-fc1b-4ed0-a226-2381f0ec4186",
            description: "Red water bottle with some marks on the side and an 'I Vote' sticker. ",
            image: "appdev_logo",
            title: "Water bottle",
            location: "Gates Hall",
            time: "12",
            date: Date(timeIntervalSince1970: 1713585103),
            status: "not found",
            email: "sonja.hinting@gmail.com",
            phone: "1234567890"
        ),
    ]
    
    
}
