//
//  File.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation

import ComposableArchitecture
import Combine

internal enum Search {
    
    // MARK: - State
    
    struct State: Equatable {
        
        // Init
        
        @BindableState var searchQuery: String
        
        init(searchQuery: String = String()) {
            self.searchQuery = searchQuery
        }
        
        // Response
        
        var users: [API.User] = []
        
        var filteredUsers: [API.User] {
            searchQuery.trimmingCharacters(in: .whitespaces).isEmpty
                ? users
                : users.filter { $0.contains(searchQuery) }
        }
        
        var error: API.ClientError?
    }
    
    // MARK: - Action
    
    enum Action: Equatable, BindableAction {
        
        case binding(BindingAction<Search.State>)
        
        case appeared
        case didReceiveResponse(Result<API.GetUserResponse, API.ClientError>)
        
    }
    
    // MARK: - Environemnt
    
    struct Environemnt {
        var getUsers: (Int) -> Effect<Action, Never>
    }
    
}

// MARK: - Reducer

internal extension Search {
    
    static let reducer = Reducer<Self.State, Self.Action, Self.Environemnt> { state, action, environment in
        
        switch action {
        case .binding:
            break
            
        case .appeared:
            return environment.getUsers(3)
                .eraseToEffect()
            
        case let .didReceiveResponse(response):
            
            switch response {
            case let .success(response):
                state.users = response.results
                
            case let .failure(error):
                state.error = error
                
            }
        }
        
        return .none
    }
    .binding()
    
}

// MARK: - Environment

extension Search.Environemnt {

    static func live() -> Self {
        .init(getUsers: { count in
            
            guard
                let url = URL(string: "https://randomuser.me/api/?results=\(count)")
            else {
                return .none
            }
            
           return URLSession.request(url: url, response: API.GetUserResponse.self)
                .catchToEffect()
                .map(Search.Action.didReceiveResponse)
        })
    }

}

// MARK: - Extensions

extension API.User {
    
    fileprivate func contains(_ query: String) -> Bool {
        fullname.contains(query) || address.contains(query) || email.contains(query)
    }
    
    var fullname: String {
        [name.first, name.last].joined(separator: " ")
    }
    
    var address: String {
        ["\(location.street.number)", location.street.name].joined(separator: " ")
    }
    
}
