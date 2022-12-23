//
//  PageView.swift
//  RecycleUI
//
//  Created by Yura on 12/22/22.
//

import SwiftUI

struct PageView<Page: View>: View {
    @State private var currentPage = 0
    
    var pages: [Page]

    var body: some View {
        ZStack(alignment: .top) {
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: UserStore().profiles.map( { Tile(profile: $0, tileSize: CGSize(width: 350, height: 350)) } ))
    }
}
