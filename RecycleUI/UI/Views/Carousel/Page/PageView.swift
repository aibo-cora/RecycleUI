//
//  PageView.swift
//  RecycleUI
//
//  Created by Yura on 12/22/22.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]

    var body: some View {
        PageViewController(pages: pages)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: [Text("")])
    }
}
