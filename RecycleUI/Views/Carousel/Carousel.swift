//
//  Carousel.swift
//  RecycleUI
//
//  Created by Yura on 8/14/22.
//

import SwiftUI

struct Carousel<Profile, Footer>: View where Profile: EntityProfile, Footer: View {
    @State private var centeredTileIndex = 0/// keep track on the visible tile by using scroll view offset and updating the index.
    @State private var offset: CGSize = .zero
    
    var data: [Profile]
    var tileSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: 350)
    var tileCornerRadius: CGFloat = 50
    
    let space = "scrollview"
    let tileSpacing: CGFloat = 10
    
    var centerIndexChanged: ((_ index: Int) -> Void)?
    var footer: ((_ index: Int) -> Footer)?
    
    @State private var detailed = false
    
    @ViewBuilder
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: tileSpacing) {
                    ForEach(Array(data.enumerated()), id: \.element) { index, profile in
                        CarouselTile(detailed: $detailed, profile: profile, tileCornerRadius: tileCornerRadius, tileSize: tileSize, spotlightOn: centeredTileIndex == index)
                            .overlay {
                                RoundedRectangle(cornerRadius: tileCornerRadius, style: .circular)
                                    .frame(width: tileSize.width, height: tileSize.height)
                                    .foregroundColor(index == centeredTileIndex ? .clear : .black)
                                    .opacity(index == centeredTileIndex ? 1 : 0.5)
                            }
                    }
                }
                .padding([.leading, .trailing], 20)
                .background {
                    GeometryReader { geometry in
                        Color.clear.preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geometry.frame(in: .named(space)).origin.x
                        )
                    }
                    // .frame(width: 0, height: 0, alignment: .center) <- Bad things happen
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { svOffset in
                        let totalTileWidth = tileSize.width + tileSpacing
                        let totalContentWidth = CGFloat(data.count) * CGFloat(tileSize.width + tileSpacing)
                        let hack = svOffset - 100
                        
                        print(svOffset, hack, totalContentWidth, totalTileWidth)
                        
                        if svOffset > -(totalContentWidth - totalTileWidth - 150) {
                            centeredTileIndex = abs(Int(hack / totalTileWidth))
                        } else {
                            centeredTileIndex = data.count - 1
                        }
                    }
                }
            }
            .coordinateSpace(name: space)
            
            footer?(centeredTileIndex)
        }
        .animation(SwiftUI.Animation.linear(duration: 0.5).delay(0.25), value: centeredTileIndex)
    }
    
    struct CarouselTile: View {
        @Binding var detailed: Bool/// Calculate offset to center a tile after detailed toggles to `true`
        
        let profile: Profile
        
        let tileCornerRadius: CGFloat
        let tileSize: CGSize
        
        let defaultProfilePhotoLocation = ""
        let spotlightOn: Bool
        
        var body: some View {
            AsyncImage(url: URL(string: profile.profilePhotoLocation ?? defaultProfilePhotoLocation)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: (detailed && spotlightOn) ? UIScreen.main.bounds.width : tileSize.width, height: (detailed && spotlightOn) ? UIScreen.main.bounds.height : tileSize.height)
                    .cornerRadius(tileCornerRadius)
                    .ignoresSafeArea()
                    .onTapGesture {
                        detailed.toggle()
                    }
                    
            } placeholder: {
                ProgressView()
            }
            .animation(Animation.easeOut(duration: 1.0), value: detailed)
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Carousel(data: UserStore().profiles, footer:  { index in
                Text("")
            })
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .previewDisplayName("iPhone 13 Pro")
            
            Carousel(data: UserStore().profiles, footer:  { index in
                Text("")
            })
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (3rd generation)"))
            .previewDisplayName("iPad Pro (11-inch) (3rd generation)")
        }
    }
}
