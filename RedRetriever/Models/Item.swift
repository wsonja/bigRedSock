//
//  Item.swift
//  A4
//
//  Created by Ethan Seiz on 12/4/24.
//

import Foundation

struct Item {
    let name: String
    let points: String
}

extension Item {
    static let dummyData = [
        Item(
            name: "water bottle",
            points: "5"),
        Item(
            name: "airpods",
            points: "20")]
}
