//
//  Button.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation
import SwiftUI

// MARK: - Button

internal extension LoginView {
    
    struct Button: View {
        
        // MARK: Init
        
        private let title: String
        private let action: () -> Void
        
        init(
            title: String,
            action: @escaping () -> Void
        ) {
            
            self.title = title
            self.action = action
        }
        
        // MARK: Body
        
        var body: some View {
            SwiftUI.Button(
                action: action,
                label: label
            )
            
            .buttonStyle(PlainButtonStyle())
        }
        
        // MARK: Label
        
        @ViewBuilder
        private func label() -> some View {
            Text(title)
                .flexibleFrame()
                .frame(height: 44.0)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .foregroundColor(Color.black)
                )
                .foregroundColor(.white)
                .font(.footnote)
        }
    }
    
}
