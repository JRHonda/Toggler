//
//  ColorSchemes.swift
//  
//
//  Created by Justin Honda on 11/23/21.
//

import SwiftUI

// TODO: - Come up with better name
public struct SwitchTriColorScheme {
    public let background: Color
    public let isOffColor: Color
    public let isOnColor: Color
    
    public init(background: Color = .gray, isOffColor: Color = .red, isOnColor: Color = .green) {
        self.background = background
        self.isOffColor = isOffColor
        self.isOnColor = isOnColor
    }
}

