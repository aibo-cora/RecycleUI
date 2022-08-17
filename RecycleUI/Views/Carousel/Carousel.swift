//
//  Carousel.swift
//  RecycleUI
//
//  Created by Yura on 8/14/22.
//

import SwiftUI

struct Carousel<Profile>: View where Profile: EntityProfile {
    @State private var centeredTileIndex = -1/// keep track on the visible tile by using a drag gesture and updating the index.
    @State private var offset: CGSize = .zero
    
    var data: [Profile]
    var tileSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: 350)
    var tileCornerRadius: CGFloat = 50
    
    let space = "scrollview"
    let tileSpacing: CGFloat = 10
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ZStack {
                LazyHStack(spacing: tileSpacing) {
                    ForEach(Array(data.enumerated()), id: \.element) { index, profile in
                        CarouselTile(centeredTileIndex: $centeredTileIndex, profile: profile, tileCornerRadius: tileCornerRadius, tileSize: tileSize)
                            .scaleEffect(index == centeredTileIndex ? 1.0 : 1.0)
                            .zIndex(Double(index == centeredTileIndex ? 100 : index))
                            .overlay {
                                RoundedRectangle(cornerRadius: tileCornerRadius, style: .circular)
                                    .frame(width: tileSize.width, height: tileSize.height)
                                    .foregroundColor(index == centeredTileIndex ? .clear : .black)
                                    .opacity(index == centeredTileIndex ? 1 : 0.5)
                            }
                            
                            // .offset(x: (UIScreen.main.bounds.width - tileSize.width) / 2, y: 0)
                            .animation(SwiftUI.Animation.easeInOut(duration: 1.0).delay(1), value: centeredTileIndex)
                    }
                }
                .background(
                    GeometryReader { geometry in
                        Color.clear.preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geometry.frame(in: .named(space)).origin
                        )
                    }
                    .frame(width: 0, height: 0))
                .padding([.leading, .trailing], 20)
            }
        }
        .background(Color.init(hex: "F5F5DC"))
        .onAppear {
            centeredTileIndex = 0
        }
        .coordinateSpace(name: space)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { svOffset in
            let totalTileWidth = tileSize.width + tileSpacing
            
            centeredTileIndex = Int(svOffset.x / totalTileWidth)
        }
    }
    
    struct CarouselTile: View {
        @Binding var centeredTileIndex: Int
        
        var profile: Profile
        
        var defaultProfilePhotoLocation = ""
        var tileCornerRadius: CGFloat
        var tileSize: CGSize
        
        var body: some View {
            ZStack {
                AsyncImage(url: URL(string: profile.profilePhotoLocation ?? defaultProfilePhotoLocation)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: tileSize.width, height: tileSize.height)
                        .cornerRadius(tileCornerRadius)
                } placeholder: {
                    ProgressView()
                }
                .overlay(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: tileCornerRadius, style: .circular)
                        .frame(width: tileSize.width, height: tileSize.height / 3.5)
                        .foregroundColor(.white)
                    Text(profile.profileInfo ?? "I am still considering what to put here.")
                        .padding()
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                }
            }
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Carousel(data: UserStore().profiles)
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
                .previewDisplayName("iPhone 13 Pro Max")
            
            Carousel(data: UserStore().profiles)
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (3rd generation)"))
                .previewDisplayName("iPad Pro (11-inch) (3rd generation)")
        }
    }
}
