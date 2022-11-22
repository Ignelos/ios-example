//
//  LoginState.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation
import ComposableArchitecture

internal enum Login {
    
    private static let emailPattern = #"^\S+@\S+\.\S+$"#
    private static let passwordLength = 6
    
    // MARK: -State
    
    struct State: Equatable {
        
        struct Input: Equatable {
            
            var value: String
            var caption: String?
            
            init(
                value: String,
                caption: String?
            ) {
                self.value = value
                self.caption = caption
            }
            
            static let empty = Self(value: "", caption: nil)
        }
        
        @BindableState var email: Input
        @BindableState var password: Input
        
        // Init
        
        init(
            email: Input,
            password: Input
        ) {
            
            self.email = email
            self.password = password
        }
        
        // Search
        
        var searchState: Search.State? = nil
        
        // Validations
        
        var isEmailValid: Bool {
            
            let regex = email.value.range(
                of: emailPattern,
                options: .regularExpression
            ) != nil
            
            return regex
        }
        
        var isPasswordValid: Bool {
            password.value.count >= passwordLength
        }

    }
    
    // MARK: -Action
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<Login.State>)
        
        case tappedLogin
        case commitedSearchReducerAction(Search.Action)
        
        case dismissedSearch
    }
    
    // MARK: -Environemnt
    
    struct Environment {
        
    }
    
    // MARK: - Reducer
    
    static let reducer = Reducer.combine(
        searchReducer,
        localReducer
    )
    
}

// MARK: - LocalReducer

private extension Login {
    
    static let localReducer = Reducer<Self.State, Self.Action, Self.Environment> { state, action, environment in
        
        switch action {
        case .binding(\.$email.value):
            state.email.caption = nil
            
        case .binding(\.$password.value):
            state.password.caption = nil
            
        case .tappedLogin:
            
            state.email.caption = state.isEmailValid
                ? nil
                : "Invalid email format"
            
            state.password.caption = state.isPasswordValid
                ? nil
                : "Password to short"
            
            if state.isEmailValid && state.isPasswordValid {
                state.searchState = .init()
            }
            
        case .commitedSearchReducerAction:
            break
            
        case .dismissedSearch:
            
            state.email.value = ""
            state.password.value = ""
            
            state.searchState = nil
            
        default:
            break
            
        }
        
        return .none
    }
    .binding()
    
}

// MARK: - SearchReducer

private extension Login {
    
    static let searchReducer = Search.reducer
        .optional()
        .pullback(
            state: \State.searchState,
            action: /Action.commitedSearchReducerAction,
            environment: { (_: Login.Environment) in .live() }
        )
    
}
