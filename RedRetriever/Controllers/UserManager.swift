//
//  UserManager.swift
//  A4
//
//  Created by Sonja Wong on 5/12/2024.
//

import Foundation

class UserManager {
    static let shared = UserManager() // Singleton instance

    var profileName: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var profilePicURL: URL?
    
    var points: Int?

    private init() {} // Private initializer to prevent creating new instances
}
