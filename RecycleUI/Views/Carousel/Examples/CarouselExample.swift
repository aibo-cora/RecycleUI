//
//  CarouselExample.swift
//  RecycleUI
//
//  Created by Yura on 8/15/22.
//

import SwiftUI

struct CarouselExample: View {
    var body: some View {
        Carousel(data: UserStore().profiles)
    }
}

struct CarouselExample_Previews: PreviewProvider {
    static var previews: some View {
        CarouselExample()
    }
}
