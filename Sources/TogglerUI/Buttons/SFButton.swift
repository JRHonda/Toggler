//
//  SFButton.swift
//  
//
//  Created by Justin Honda on 11/29/21.
//

import SwiftUI
import SFSafeSymbols

public struct SFButton: View {
    
    public let action: () -> Void
    public let sfSymbol: SFSymbol
    
    public init(action: @escaping () -> Void, sfSymbol: SFSymbol) {
        self.action = action
        self.sfSymbol = sfSymbol
    }
    
    /// * For watchOS: Change button style to `.plain` or `.borderless` (if supporting 8.0+)
    public var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: sfSymbol.rawValue)
        }
    }
}

struct SFButton_Previews: PreviewProvider {
    static var previews: some View {
        SFButton(action: { print("tapped button") }, sfSymbol: ._11Circle)
            .previewDevice("Apple Watch Series 6 - 44mm")
    }
}
