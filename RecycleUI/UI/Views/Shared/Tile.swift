//
//  Tile.swift
//  RecycleUI
//
//  Created by Yura on 12/22/22.
//

import SwiftUI

struct Tile<Profile>: View where Profile: EntityProfile {
    let profile: Profile
    let tileSize: CGSize
    
    var body: some View {
        ImageView(url: URL(string: profile.profilePhotoLocation ?? ""), frame: tileSize)
            .cornerRadius(25)
            .ignoresSafeArea()
    }
}

struct Tile_Previews: PreviewProvider {
    static var previews: some View {
        Tile(profile: UserStore().profiles.first!, tileSize: UIScreen.main.bounds.size)
    }
}
