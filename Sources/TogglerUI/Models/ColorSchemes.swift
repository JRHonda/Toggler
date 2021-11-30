//
//  ColorSchemes.swift
//  
//
//  Created by Justin Honda on 11/23/21.
//

import SwiftUI

public struct Colors {
    public static let togglerGray = Color.init(.sRGB, red: 0.25, green: 0.25, blue: 0.25, opacity: 1)
}

public struct BiColorScheme {
    public let colorOne: Color
    public let colorTwo: Color
    
    public init(colorOne: Color = Colors.togglerGray, colorTwo: Color = .green) {
        self.colorOne = colorOne
        self.colorTwo = colorTwo
    }
}

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

