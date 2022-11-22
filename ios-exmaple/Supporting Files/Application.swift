//
//  ios_exmapleApp.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import SwiftUI

@main
struct Application: App {
    var body: some Scene {
        WindowGroup {
            LoginView(store: .init(
                initialState: .init(email: .empty, password: .empty),
                reducer: Login.reducer,
                environment: .init())
            )
        }
    }
}
