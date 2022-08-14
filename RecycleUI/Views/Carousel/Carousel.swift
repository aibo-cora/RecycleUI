//
//  Carousel.swift
//  RecycleUI
//
//  Created by Yura on 8/14/22.
//

import SwiftUI

struct Carousel: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(Array(UserStore().profiles.enumerated()), id: \.element) { index, profile in
                    CarouselTile(data: <#T##[DiscoverUser]#>, index: <#T##Int#>, defaultProfilePhotoLocation: <#T##String#>, cornerRadius: <#T##CGFloat#>, tileSize: <#T##CGSize#>)
                }
            }
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel()
    }
}
