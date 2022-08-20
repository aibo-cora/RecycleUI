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
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: UserStore().profiles.first?.profilePhotoLocation ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .onTapGesture {
                        detailed.toggle()
                    }
                    .frame(width: detailed ? UIScreen.main.bounds.width : 200, height: detailed ? UIScreen.main.bounds.height : 200, alignment: .center)
            } placeholder: {
                ProgressView()
            }
            if detailed {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .transition(.move(edge: .bottom))
            } else {
                EmptyView()
            }
        }
        .animation(Animation.easeOut(duration: 1.0), value: detailed)
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
