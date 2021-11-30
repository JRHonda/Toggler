//
//  Slider.swift
//  
//
//  Created by Justin Honda on 11/24/21.
//

import SwiftUI

public struct Slider: View {
    
    // MARK: - Properties
    
    public enum Constants {
        public static let defaultFramewidth: CGFloat = 150
        fileprivate static let padding8: CGFloat = 8
        fileprivate static let frameHeight: CGFloat = 32
        fileprivate static let rectangleSliderHeight: CGFloat = frameHeight / 2.5
    }
    
    public var width: CGFloat
    public var colorScheme: BiColorScheme
    @Binding public var hasReachedEnd: Bool
    
    @State private var sliderPosition: CGSize = .zero
    /// used to support preview functionality when working in SPM project
    @State private var sliderHasReachedEnd: Bool = false
    
    
    // MARK: - Init
    
    public init(width: CGFloat = Constants.defaultFramewidth,
                colorScheme: BiColorScheme = .init(),
                hasReachedEnd: Binding<Bool>) {
        self.width = width
        self.colorScheme = colorScheme
        self._hasReachedEnd = hasReachedEnd
    }
    
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(colorScheme.colorOne)
                .frame(height: Constants.rectangleSliderHeight)
                .cornerRadius(Constants.rectangleSliderHeight / 2)
                .padding([.trailing, .leading], Constants.padding8)
                .padding(.leading, sliderPosition.width)
            
            HStack {
                GeometryReader { geometry in
                    ZStack {
                        Image(systemName: "chevron.right.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(colorScheme.colorTwo)
                            .frame(width: Constants.frameHeight,
                                   height: Constants.frameHeight,
                                   alignment: .center)
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
        Slider(hasReachedEnd: $hasReachedEnd)
    }
}
