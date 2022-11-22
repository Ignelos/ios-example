//
//  Error.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation

extension API {
    
    public struct ClientError: Error, Codable, Equatable {
        public var status: Int
        public var statusCode: Int?
        public var message: String?
    }
    
}
