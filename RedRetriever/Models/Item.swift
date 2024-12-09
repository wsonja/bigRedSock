//
//  Item.swift
//  A4
//
//  Created by Sonja Wong on 6/12/2024.
//

import Foundation
struct ItemResponse: Codable {
    let items: [Item]
}
struct Item: Codable {
    let id: Int
    let title: String
    let description: String
    let location: String?
    let preprocessed_description: String?
    let status: String
    var image: String? // Base64 image string
    let finder_id: Int?
    let requests: [miniRequest] // Nested requests
    let email: String
    let phone: String
    let date: Double
}
