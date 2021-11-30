//
//  Button+extensions.swift
//  
//
//  Created by Justin Honda on 11/29/21.
//

import SwiftUI
import SFSafeSymbols

extension Button {
    /// Adds an SFSymbol as the content of a Button view
    /// - Parameters:
    ///   - action: Triggered action when user taps button
    ///   - sfSymbol: The SFSymbol the user wants to display inside the button
    ///   - label: The SFSymbol is passed into the view builder which can used as desired.
    public init(action: @escaping () -> Void, sfSymbol: SFSymbol, @ViewBuilder label: (SFSymbol) -> Label) {
        self.init(action: action, label: { label(sfSymbol) })
    }
}
