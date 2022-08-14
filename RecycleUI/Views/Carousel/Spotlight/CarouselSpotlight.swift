//
//  CarouselSpotlight.swift
//  RecycleUI
//
//  Created by Yura on 8/13/22.
//

import SwiftUI

struct CarouselSpotlight: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CarouselSpotlight_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CarouselSpotlight()
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
                .previewDisplayName("iPhone 13 Pro Max")
            
            CarouselSpotlight()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (3rd generation)"))
                .previewDisplayName("iPad Pro (11-inch) (3rd generation)")
        }
    }
}
