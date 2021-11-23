//
//  Pill.swift
//  
//
//  Created by Justin Honda on 11/22/21.
//

import SwiftUI

public struct Pill: View {
    public let leftText: String
    public let rightText: String
    public let height: CGFloat
    public let width: CGFloat
    public var isOn: Binding<Bool>
    
    private var cornerRadius: CGFloat { height / 2 }
    
    @State private var buttonIndicatorPaddingEdge: Edge.Set
    
    private var indicatorAnimation: Animation {
        .interactiveSpring()
    }
    
    public init(leftText: String,
                rightText: String,
                height: CGFloat,
                width: CGFloat,
                isOn: Binding<Bool>) {
        self.leftText = leftText
        self.rightText = rightText
        self.height = height
        self.width = width
        self.isOn = isOn
        self.buttonIndicatorPaddingEdge = isOn.wrappedValue
        ? .leading
        : .trailing
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .cornerRadius(cornerRadius)
            ZStack {
                Rectangle()
                    .foregroundColor(.green)
                    .padding(buttonIndicatorPaddingEdge, width / 2)
                    .cornerRadius(cornerRadius)
            }
            ZStack {
                HStack {
                    Spacer()
                    Text(leftText)
                    
                    Spacer()
                    Rectangle().frame(width: 2)
                    Spacer()
                    
                    Text(rightText)
                    Spacer()
                }
            }
            
            Color.clear
                .contentShape(Rectangle())
                .frame(width: width / 2)
                .position(x: width * 0.25, y: height / 2)
                .onTapGesture {
                    withAnimation(indicatorAnimation) {
                        self.buttonIndicatorPaddingEdge = .trailing
                    }
                }
                .zIndex(9999)
            
            Color.clear
                .contentShape(Rectangle())
                .frame(width: width / 2)
                .position(x: width * 0.75, y: height / 2)
                .onTapGesture {
                    withAnimation(indicatorAnimation) {
                        self.buttonIndicatorPaddingEdge = .leading
                    }
                }
                .zIndex(9999)
        }
        .frame(width: width, height: height, alignment: .center)
        .onAppear {
            print("pill has appeared \(self)")
        }
    }
}

public struct Pill_Previews: PreviewProvider {
    public static var previews: some View {
        Pill(leftText: "Off",
             rightText: "On",
             height: 30,
             width: 100,
             isOn: .constant(false))
    }
}
