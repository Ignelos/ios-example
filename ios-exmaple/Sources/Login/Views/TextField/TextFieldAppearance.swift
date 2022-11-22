//
//  TextFieldAppearance.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation
import SwiftUI

// MARK: - Environment

internal struct TextFieldAppearance {
    
    var caption: String? = nil
    
    enum Style {
        case plain, secured
    }
    
    var style: Style = .plain
    
}

internal extension EnvironmentValues {

    private struct TextFieldEnvironmentKey: EnvironmentKey {
        public static var defaultValue: TextFieldAppearance = .init()
    }

    var textFieldAppearance: TextFieldAppearance {
        get { self[TextFieldEnvironmentKey.self] }
        set { self[TextFieldEnvironmentKey.self] = newValue }
    }

}

// MARK: - API

public extension View {
    
    @ViewBuilder
    func textFieldAppearance<T>(_ path: WritableKeyPath<TextFieldAppearance, T>, value: T) -> some View {
        transformEnvironment(\.textFieldAppearance) { environment in
            environment[keyPath: path] = value
        }
    }
    
}
