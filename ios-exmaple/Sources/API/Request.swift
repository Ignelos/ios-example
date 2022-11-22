//
//  Request.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation
import Combine

extension URLSession {
    
    static func request<Response: Codable>(url: URL, response: Response.Type) -> AnyPublisher<Response, API.ClientError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .mapError { API.ClientError(status: $0.code.rawValue, statusCode: $0.errorCode, message: $0.localizedDescription) }
            .flatMap { response -> AnyPublisher<Response, API.ClientError> in
                Just(response.data)
                    .tryMap { _ in
                        
                        print(String(data: response.data, encoding: .utf8))
                        
                        do {
                            try JSONDecoder().decode(Response.self, from: response.data)
                        } catch {
                            print(error)
                        }
                        
                        return response.data
                    }
                    .decode(type: Response.self, decoder: JSONDecoder())
                    .mapError {
                        ($0 as? API.ClientError) ?? .init(status: 0, statusCode: 0, message: $0.localizedDescription)
                    }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
