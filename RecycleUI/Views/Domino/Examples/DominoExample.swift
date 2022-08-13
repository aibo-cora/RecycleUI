//
//  DominoExample.swift
//  RecycleUI
//
//  Created by Yura on 8/13/22.
//

import SwiftUI

struct DominoExample: View {
    var body: some View {
        DominoStack(data: UserStore().discoverUsers, tileCount: 3) {
            // remove action
            // UserStore().discoverUsers.removeFirst()
        }
    }
}

struct DominoExample_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DominoExample()
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
                .previewDisplayName("iPhone 13 Pro Max")
            
            DominoExample()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (3rd generation)"))
                .previewDisplayName("iPad Pro (11-inch) (3rd generation)")
        }
    }
}
