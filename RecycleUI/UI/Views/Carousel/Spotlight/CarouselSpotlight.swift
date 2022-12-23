//
//  Carousel.swift
//  RecycleUI
//
//  Created by Yura on 8/14/22.
//  Updated on 12/22/22.

import SwiftUI

/// Scroll the tiles horizontally highlighting the one in the center of screen.
struct CarouselSpotlight<Profile, Footer>: View where Profile: EntityProfile, Footer: View {
    /// Keep track on the visible tile by using scroll view offset and updating the index.
    @State private var centeredTileIndex = 0
    
    var data: [Profile]
    
    var tileSize = CGSize(width: 350, height: 350)
    
    let space = "scrollview"
    let tileSpacing: CGFloat = 10
    
    var centerIndexChanged: ((_ index: Int) -> Void)?
    var footer: ((_ index: Int) -> Footer)?
    
    @ViewBuilder
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: tileSpacing) {
                    ForEach(Array(data.enumerated()), id: \.element) { index, profile in
                        let spotlight = centeredTileIndex == index
                        
                        Tile(profile: profile, tileSize: tileSize)
                            .overlay {
                                RoundedRectangle(cornerRadius: 25, style: .circular)
                                    .foregroundColor(spotlight ? .clear : .black)
                                    .opacity(spotlight ? 1 : 0.5)
                            }
                    }
                }
                .padding([.leading, .trailing], tileSpacing)
                .background {
                    GeometryReader { geometry in
                        Color.clear.preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geometry.frame(in: .named(space)).origin.x
                        )
                    }
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { updateIndex(using: $0) }
                }
            }
            .coordinateSpace(name: space)
            
            footer?(centeredTileIndex)
        }
        .animation(SwiftUI.Animation.linear(duration: 0.5).delay(0.25), value: centeredTileIndex)
    }
    
    func updateIndex(using svOffset: CGFloat) {
        let totalTileWidth = tileSize.width + tileSpacing
        let totalContentWidth = CGFloat(data.count) * CGFloat(tileSize.width + tileSpacing)
        let hack = svOffset - 100
        
        print(svOffset, hack, totalContentWidth, totalTileWidth - tileSpacing)
        
        if svOffset > -(totalContentWidth - totalTileWidth - 150) {
            centeredTileIndex = abs(Int(hack / totalTileWidth))
        } else {
            centeredTileIndex = data.count - 1
        }
    }
}

struct CarouselSpotlight_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CarouselSpotlight(data: UserStore().profiles, footer:  { index in
                Text("")
            })
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .previewDisplayName("iPhone 13 Pro")
            
            CarouselSpotlight(data: UserStore().profiles, footer:  { index in
                Text("")
            })
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
            .previewDisplayName("iPad Pro (11-inch) (4th generation)")
        }
    }
}
