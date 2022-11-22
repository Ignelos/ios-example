//
//  File.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation
import SwiftUI

// MARK: - ListItem

extension SearchView {
    
    struct ListItem: View {
        
        private let user: API.User
        
        init(user: API.User) {
            self.user = user
        }
        
        // MARK: Body
        
        var body: some View {
            HStack(
                alignment: .center,
                spacing: Spacing.sm
            ) {
                
                icon()
                content()
            }
            .flexibleFrame(alignment: .leading)
        }
        
        // MARK: Icon
        
        @ViewBuilder
        private func icon() -> some View {
            URL(string: user.picture.large)
                .flatMap {
                    AsyncImage(url: $0) { phase in
                        
                        phase.image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 48.0, height: 48.0)
                            .cornerRadius(8)
                    }
                }
        }
        
        // MARK: Content
        
        @ViewBuilder
        private func content() -> some View {
            VStack(
                alignment: .leading,
                spacing: .zero
            ) {
                
                Text(user.fullname)
                    .fontWeight(.bold)
                
                Text(user.address)
                Text(user.email)
            }
            .font(.footnote)
        }
        
    }
    
}
