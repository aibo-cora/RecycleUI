//
//  ScaledText.swift
//  RecycleUI
//
//  Created by Yura on 12/23/22.
//

import SwiftUI

struct ScaledText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.5)
            .padding([.leading, .trailing], 20)
            .frame(maxHeight: 150)
    }
}

struct ScaledText_Previews: PreviewProvider {
    static var previews: some View {
        ScaledText(text: "Hi")
    }
}
