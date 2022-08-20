//
//  CarouselExpandedTile.swift
//  RecycleUI
//
//  Created by Yura on 8/20/22.
//

import SwiftUI

struct CarouselExpandedTile: View {
    @State private var detailed = false
    
    var index: Int = 0
    
    var body: some View {
        AsyncImage(url: URL(string: UserStore().profiles.first?.profilePhotoLocation ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 200, height: 200, alignment: .center)
    }
}

struct CarouselExpandedTile_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CarouselExpandedTile()
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
                .previewDisplayName("iPhone 13 Pro")
            
            CarouselExpandedTile()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (3rd generation)"))
                .previewDisplayName("iPad Pro (11-inch) (3rd generation)")
        }
    }
}
