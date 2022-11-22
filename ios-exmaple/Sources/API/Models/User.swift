//
//  User.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation


enum API {
    
    struct User: Codable, Equatable, Hashable {
        
        struct Name: Codable, Equatable, Hashable {
            let first: String
            let last: String
        }
        
        let name: Name
        let email: String
        
        struct Location: Codable, Equatable, Hashable {
            
            struct Street: Codable, Equatable, Hashable {
                let number: Int
                let name: String
            }
            
            let street: Street
            
        }
        
        let location: Location
        
        struct Picture: Codable, Equatable, Hashable {
            let large: String
        }
        
        let picture: Picture
        
    }

    struct GetUserResponse: Codable, Equatable, Hashable {
        let results: [API.User]
    }

}
