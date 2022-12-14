//
//  LoginView.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation

import SwiftUI
import ComposableArchitecture

internal struct LoginView: View {
    
    // MARK: Store
    
    private let store: Store<Login.State, Login.Action>
    
    init(store: Store<Login.State, Login.Action>) {
        self.store = store
    }
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            
            background()
            content()
        }
        .background(searchNavigation())
    }
    
    // MARK: Components
    
    @ViewBuilder
    private func background() -> some View {
        Color.clear
            .flexibleFrame()
    }
    
    @ViewBuilder
    private func content() -> some View {
        WithViewStore(store) { viewStore in
            
            VStack(
                alignment: .center,
                spacing: Spacing.sm
            ) {
                
                Spacer()
                
                Text("Login")
                    .font(.title)
                
                Spacer()
                
                TextField(
                    placeholder: "Email",
                    text: viewStore.binding(\.$email.value)
                )
                .textFieldAppearance(\.caption, value: viewStore.email.caption)
                
                TextField(
                    placeholder: "Password",
                    text: viewStore.binding(\.$password.value)
                )
                .textFieldAppearance(\.style, value: .secured)
                .textFieldAppearance(\.caption, value: viewStore.password.caption)
                
                Button(
                    title: "Login",
                    action: { viewStore.send(.tappedLogin) }
                )
                
                Spacer()
                Spacer()
            }
            .animation(.default, value: viewStore.state)
        }
        .padding(.horizontal, Spacing.globalMargin)
    }
    
    // MARK: - Navigation
    
    @ViewBuilder
    private func searchNavigation() -> some View {
        WithViewStore(store) { viewStore in
            
            let destination = IfLetStore(
                store.scope(state: \.searchState, action: Login.Action.commitedSearchReducerAction),
                then: SearchView.init
            )
            
            let isPresented = viewStore.binding(get: { $0.searchState != nil }, send: .dismissedSearch)
            
            Color.clear
                .sheet(isPresented: isPresented, content: { destination})
        }
    }
    
}
