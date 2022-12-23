//
//  PageExample.swift
//  RecycleUI
//
//  Created by Yura on 12/23/22.
//

import SwiftUI

struct PageExample: View {
    var body: some View {
        PageView(pages: UserStore().profiles.map( { Detailed(profile: $0) } ))
            .frame(maxWidth: .infinity, maxHeight: 500)
    }
    
    struct Detailed<Profile: EntityProfile>: View {
        let profile: Profile
        
        var body: some View {
            VStack {
                Tile(profile: profile, tileSize: CGSize(width: 350, height: 350))
                ScaledText(text: profile.profileInfo ?? "")
            }
        }
    }
}

struct PageExample_Previews: PreviewProvider {
    static var previews: some View {
        PageExample()
    }
}
