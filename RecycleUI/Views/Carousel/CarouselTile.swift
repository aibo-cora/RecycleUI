//
//  CarouselTile.swift
//  RecycleUI
//
//  Created by Yura on 8/13/22.
//

import SwiftUI

struct CarouselTile: View {
    var data: [DiscoverUser]
    var index = 0
    var defaultProfilePhotoLocation = ""
    var cornerRadius: CGFloat = 50
    var tileSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: 350)
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: data[index].profilePhotoLocation ?? defaultProfilePhotoLocation)) { image in
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
                Text(data[index].profileInfo ?? "I am still considering what to put here.")
                    .padding()
            }
        }
    }
}

struct CarouselTile_Previews: PreviewProvider {
    static var previews: some View {
        CarouselTile(data: UserStore().profiles)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")
    }
}
