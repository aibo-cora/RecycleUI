//
//  CarouselExample.swift
//  RecycleUI
//
//  Created by Yura on 8/15/22.
//

import SwiftUI

struct SpotlightExample: View {
    var body: some View {
        CarouselSpotlight(data: UserStore().profiles, footer: { index in
            ScaledText(text: UserStore().profiles[index].profileInfo ?? "I am still considering what to put here.")
        })
    }
}

struct CarouselExample_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SpotlightExample()
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
                .previewDisplayName("iPhone 13 Pro")
            
            SpotlightExample()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (3rd generation)"))
                .previewDisplayName("iPad Pro (11-inch) (3rd generation)")
        }
    }
}
