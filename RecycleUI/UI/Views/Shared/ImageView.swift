//
//  ImageView.swift
//  RecycleUI
//
//  Created by Yura on 12/22/22.
//

import SwiftUI

struct ImageView: View {
    let url: URL?
    let frame: CGSize
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: frame.width, height: frame.height)
        } placeholder: {
            ProgressView()
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: URL(string: "https://cdn.pixabay.com/photo/2022/07/25/10/19/mountain-7343375_960_720.jpg"), frame: CGSize(width: 200, height: 350))
    }
}
