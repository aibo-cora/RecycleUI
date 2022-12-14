//
//  CarouselExample.swift
//  RecycleUI
//
//  Created by Yura on 8/15/22.
//

import SwiftUI

struct CarouselExample: View {
    var body: some View {
        CarouselSpotlight(data: UserStore().profiles, footer: { index in
            Text(UserStore().profiles[index].profileInfo ?? "I am still considering what to put here.")
                .lineLimit(3)
                .minimumScaleFactor(0.5)
                .padding([.leading, .trailing], 20)
                .frame(maxHeight: 150)
        })
    }
}

struct CarouselExample_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CarouselExample()
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
                .previewDisplayName("iPhone 13 Pro")
            
            CarouselExample()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (3rd generation)"))
                .previewDisplayName("iPad Pro (11-inch) (3rd generation)")
        }
    }
}
