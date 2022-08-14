//
//  Carousel.swift
//  RecycleUI
//
//  Created by Yura on 8/14/22.
//

import SwiftUI

struct Carousel<Profile>: View where Profile: DominoProfile {
    var data: [Profile]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(data, id: \.self) { profile in
                    CarouselTile(profile: profile)
                }
            }
        }
        .background(Color.init(hex: "F5F5DC"))
    }
    
    struct CarouselTile: View {
        var profile: Profile
        
        var defaultProfilePhotoLocation = ""
        var cornerRadius: CGFloat = 50
        var tileSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: 350)
        
        var body: some View {
            ZStack {
                AsyncImage(url: URL(string: profile.profilePhotoLocation ?? defaultProfilePhotoLocation)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: tileSize.width, height: tileSize.height)
                        .cornerRadius(cornerRadius)
                } placeholder: {
                    ProgressView()
                }
                .overlay(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .circular)
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
