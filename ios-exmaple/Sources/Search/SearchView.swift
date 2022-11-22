//
//  SearchView.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation

import SwiftUI
import ComposableArchitecture

internal struct SearchView: View {
    
    // MARK: Store
    
    private let store: Store<Search.State, Search.Action>
    
    init(store: Store<Search.State, Search.Action>) {
        self.store = store
    }
    
    // MARK: Body
    
    var body: some View {
        NavigationView {
            
            WithViewStore(store) { viewStore in
                VStack {
                    content()
                        .searchable(text: viewStore.binding(\.$searchQuery))
                }
                .navigationTitle("Search")
                .onAppear { viewStore.send(.appeared) }
            }
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        
        let localStore = store.scope(state: \.filteredUsers)
        
        WithViewStore(localStore) { viewStore in
            List {
                ForEach(viewStore.state, id: \.self, content: ListItem.init(user:))
            }
        }
    }
    
}

