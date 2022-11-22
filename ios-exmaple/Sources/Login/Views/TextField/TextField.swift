//
//  File.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation
import SwiftUI

// MARK: - TextField

internal extension LoginView {
    
    struct TextField: View {
        
        // MARK: Environment
        
        @Environment(\.textFieldAppearance) private var appearance
        
        // MARK: Init
        
        private let placeholder: String
        @Binding private var text: String
        
        init(placeholder: String, text: Binding<String>) {
            self.placeholder = placeholder
            self._text = text
        }
        
        // MARK: Body
        
        var body: some View {
            VStack(
                alignment: .leading,
                spacing: Spacing.xxs
            ) {
                
                content()
                caption()
            }
        }
        
        // MARK: Content
        
        @ViewBuilder
        private func content() -> some View {
            
            let roundedShape = RoundedRectangle(cornerRadius: 8, style: .continuous)
            let borderLineWidth: CGFloat = appearance.caption != nil ? 1.0 : .zero
            
            textField()
                .padding(Spacing.sm)
                .background(
                    roundedShape
                        .foregroundColor(Color(.secondarySystemBackground))
                )
                .overlay(
                    roundedShape
                        .stroke(.red, lineWidth: borderLineWidth)
                )
                .animation(.default, value: appearance.caption)
                .font(.footnote)
        }
        
        @ViewBuilder
        private func textField() -> some View {
            switch appearance.style {
            case .plain:
                SwiftUI.TextField(
                    placeholder,
                    text: _text
                )
                
            case .secured:
                SwiftUI.SecureField(
                    placeholder,
                    text: _text
                )
                
            }
        }
        
        @ViewBuilder
        private func caption() -> some View {
            appearance.caption.flatMap {
                Text($0)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        
    }
    
}
