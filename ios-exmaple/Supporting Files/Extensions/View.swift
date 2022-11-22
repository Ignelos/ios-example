//
//  View.swift
//  ios-exmaple
//
//  Created by Ignas Jasiunas on 2022-11-22.
//

import Foundation
import SwiftUI

public extension View {
    
    func flexibleFrame() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}
