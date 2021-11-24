//
//  SliderToggle.swift
//  
//
//  Created by Justin Honda on 11/24/21.
//

import SwiftUI

public struct SliderToggle: View {
    
    // MARK: - Properties
    
    private enum Constants {
        static let padding8: CGFloat = 8
        static let frameHeight: CGFloat = 32
        static let rectangleSliderHeight: CGFloat = frameHeight / 2.5
    }
    
    public var width: CGFloat
    @Binding public var hasReachedEnd: Bool
    
    @State private var sliderPosition: CGSize = .zero
    /// used to support preview functionality when working in SPM project
    @State private var sliderHasReachedEnd: Bool = false
    
    
    // MARK: - Init
    
    public init(width: CGFloat = 150, hasReachedEnd: Binding<Bool>) {
        self.width = width
        self._hasReachedEnd = hasReachedEnd
    }
    
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.init(.sRGB, red: 0.25, green: 0.25, blue: 0.25, opacity: 1))
                .frame(height: Constants.rectangleSliderHeight)
                .cornerRadius(Constants.rectangleSliderHeight / 2)
                .padding([.trailing, .leading], Constants.padding8)
                .padding(.leading, sliderPosition.width)
            
            HStack {
                GeometryReader { geometry in
                    ZStack {
                        Image(systemName: "chevron.right.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.green)
                            .frame(width: Constants.frameHeight, height: Constants.frameHeight, alignment: .center)
                            .offset(x: sliderPosition.width)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        guard hasReachedEnd == false,
                                              value.translation.width >= getNormalizedEndPoint(using: geometry)
                                        else {
                                            sliderPosition = value.translation
                                            return
                                        }
                                        
                                        sliderHasReachedEnd = true
                                        hasReachedEnd = true
                                    }
                                    .onEnded { value in
                                        guard hasReachedEnd == false else {
                                            return
                                        }
                                        
                                        withAnimation {
                                            sliderHasReachedEnd = false
                                            hasReachedEnd = false
                                            sliderPosition = .zero
                                        }
                                    }
                            ).disabled(sliderHasReachedEnd)
                    }
                }.frame(height: Constants.frameHeight, alignment: .center)
                
                Spacer()
            }
        }
        .foregroundColor(.clear)
        .frame(width: width, height: Constants.frameHeight, alignment: .center)
    }
    
    
    // MARK: - Internal
    
    /// TODO
    /// - Parameter proxy: GeometryReader proxy
    /// - Returns: The value used to determine the end point for the slider
    func getNormalizedEndPoint(using proxy: GeometryProxy) -> CGFloat {
        return proxy.size.width - Constants.padding8 - (Constants.frameHeight / 2)
    }
}


// MARK: - PreviewProvider

public struct SliderToggle_Previews: PreviewProvider {
    
    @State static var hasReachedEnd: Bool = false
    
    public static var previews: some View {
        SliderToggle(hasReachedEnd: $hasReachedEnd)
    }
}
