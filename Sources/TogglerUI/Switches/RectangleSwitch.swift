//
//  RectangleSwitch.swift
//  
//
//  Created by Justin Honda on 11/23/21.
//

import SwiftUI

public struct RectangleSwitch: View {
    
    private enum Constants {
        static let stateChangeAnimationDuration = 0.25
        static let instantAnimationDuration = 0.0001
    }
    
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
    @State private var shadowColor: Color = .black
    

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
                .foregroundColor(switchStateIsOn
                                 ? colorScheme.isOnColor
                                 : colorScheme.isOffColor)
                .padding(switchIndicatorEdgeSet, width / 2)
                .shadow(color: shadowColor, radius: 1, x: .zero, y: .zero)
                // clips shadow outside of container
                .mask(Rectangle())
                
            ZStack {
                HStack {
                    Spacer()
                    Text(leftText)
                    Spacer()
                    Spacer()
                    Text(rightText)
                    Spacer()
                }
            }
            
            ZStack {
                // left (off)
                Color.clear
                    .contentShape(Rectangle())
                    .frame(width: width / 2)
                    .position(x: 0.25 * width, y: height / 2)
                    .onTapGesture { performStateChangeWithAnimation() }
                    .disabled(!switchStateIsOn)
                
                // right (on)
                Color.clear
                    .contentShape(Rectangle())
                    .frame(width: width / 2)
                    .position(x: 0.75 * width, y: height / 2)
                    .onTapGesture { performStateChangeWithAnimation() }
                    .disabled(switchStateIsOn)
            }
        }
        .frame(width: width, height: height, alignment: .center)
    }
    
    
    // MARK: - Private
    private func performStateChangeWithAnimation() {
        shadowColor = shadowColor.opacity(0.5)
        withAnimation(.easeIn(duration: Constants.stateChangeAnimationDuration)) {
            isOn.toggle()
            switchStateIsOn.toggle()
            switchIndicatorEdgeSet = switchStateIsOn ? .leading : .trailing
        }
        
        let identityAnimation = Animation
            .easeIn(duration: Constants.instantAnimationDuration)
            .delay(Constants.stateChangeAnimationDuration)
        withAnimation(identityAnimation) {
            shadowColor = .black
        }
    }
}


// MARK: - PreviewProvider
public struct RectangleSwitch_Previews: PreviewProvider {
    @State public static var isOn: Bool = false
    
    public static var previews: some View {
        RectangleSwitch(leftText: "Off", rightText: "On", isOn: $isOn)
    }
}
