//
//  RectangleSwitch.swift
//  
//
//  Created by Justin Honda on 11/23/21.
//

import SwiftUI

public struct RectangleSwitch: View {
    
    // MARK: - Properties
    public var height: CGFloat
    public var width: CGFloat
    public var leftText: String
    public var rightText: String
    public var colorScheme: SwitchTriColorScheme
    @Binding public var isOn: Bool
    
    @State private var switchIndicatorEdgeSet: Edge.Set
    /// used to support preview functionality when working in SPM project
    @State private var switchStateIsOn: Bool = false
    
    
    // MARK: - Init
    public init(
        height: CGFloat = 30,
        width: CGFloat = 100,
        leftText: String = "",
        rightText: String = "",
        colorScheme: SwitchTriColorScheme = .init(),
        isOn: Binding<Bool>
    ) {
        self.height = height
        self.width = width
        self.leftText = leftText
        self.rightText = rightText
        self.colorScheme = colorScheme
        self.switchIndicatorEdgeSet = isOn.wrappedValue ? .leading : .trailing
        self._isOn = isOn
    }
    
    
    // MARK: - Body
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(colorScheme.background)
            
            Rectangle()
                .foregroundColor(switchStateIsOn ? colorScheme.isOnColor : colorScheme.isOffColor)
                .padding(switchIndicatorEdgeSet, width / 2)
            
            ZStack {
                HStack {
                    Spacer()
                    Text(leftText)
                    Spacer()
                    Rectangle().frame(width: 1)
                    Spacer()
                    Text(rightText)
                    Spacer()
                }
            }
            
            ZStack {
                // left
                Color.clear
                    .contentShape(Rectangle())
                    .frame(width: width / 2)
                    .position(x: 0.25 * width, y: height / 2)
                    .onTapGesture {
                        withAnimation(.interactiveSpring()) {
                            switchIndicatorEdgeSet = .trailing
                            isOn = false
                            switchStateIsOn = false
                        }
                    }
                
                // right
                Color.clear
                    .contentShape(Rectangle())
                    .frame(width: width / 2)
                    .position(x: 0.75 * width, y: height / 2)
                    .onTapGesture {
                        withAnimation(.interactiveSpring()) {                            switchIndicatorEdgeSet = .leading
                            isOn = true
                            switchStateIsOn = true
                        }
                    }
            }
        }
        .frame(width: width, height: height, alignment: .center)
    }
}

// MARK: - PreviewProvider
public struct RectangleSwitch_Previews: PreviewProvider {
    @State static var isOn: Bool = false
    
    public static var previews: some View {
        RectangleSwitch(leftText: "Off", rightText: "On", isOn: $isOn)
    }
}
