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
        
        // Validations
        
        var isEmailValid: Bool {
            
            let regex = email.value.range(
                of: emailPattern,
                options: .regularExpression
            ) != nil
            
            return regex
        }
        
        var isPasswordValid: Bool {
            password.value.count >= 6
        }
        
        // Button
        
        var isButtonDisabled: Bool { !(isEmailValid && isPasswordValid) }
        
    }
    
    // MARK: -Action
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<Login.State>)
        case tappedLogin
    }
    
    // MARK: -Environemnt
    
    struct Environemnt {
        
    }
    
}

// MARK: - Reducer

internal extension Login {
    
    static let reducer = Reducer<Self.State, Self.Action, Self.Environemnt> { state, action, environment in
        
        switch action {
        case .binding(\.$email.value):
            state.email.caption = state.isEmailValid || state.email.value.isEmpty
                ? nil
                : "Invalid email format"
            
        case .binding(\.$password.value):
            state.password.caption = state.isPasswordValid || state.password.value.isEmpty
                ? nil
                : "Password to short"
            
        case .tappedLogin:
            break
            
        default:
            break
            
        }
        
        return .none
    }
    .binding()
    
}
