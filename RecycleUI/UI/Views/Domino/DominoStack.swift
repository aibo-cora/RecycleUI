//
//  DominoStack.swift
//  RecycleUI
//
//  Created by Yura on 8/13/22.
//

import SwiftUI

/**
 A view composed of individual tiles stacked together in a `ZStack`.
 - Author:
 Yura
 - parameters:
    - data: array, whose elements conform to the `EntityProfile` protocol.
    - tileCount: will be used to specify how many views will be displayed in a stack.
    - removeAction: closure will execute if the top tile is dragged to either side by more than `100` points and released.
 - Important:
 If the `profilePhotoLocation` has an invalid URL, the tile will display a continuous activity indicator. Provide a default URL with a backup image.
 - Version:
 1.0
 
 Animation to bring up the next tile after the top one was removed.
 */
public struct DominoStack<Profile>: View where Profile: EntityProfile {
    @State private var offset = CGSize.zero
    
    var data: [Profile]
    var tileCount: Int
    var removeAction: (() -> Void)? = nil
    var defaultProfilePhotoLocation: String
    
    public init(data: [Profile], tileCount: Int = 3, defaultProfilePhotoLocation: String = "", action: (() -> Void)?) {
        self.data = data
        self.tileCount = tileCount
        self.defaultProfilePhotoLocation = defaultProfilePhotoLocation
        self.removeAction = action
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            ForEach(Array(data.enumerated()), id: \.element) { index, profile in
                let flag = index == 0
                
                DominoTile(profile: profile, scale: 1 - 0.1 * CGFloat(index), detailed: flag, staggered: true, index: index)
                    .zIndex(-Double(index))
                    .rotationEffect(flag ? .degrees(Double(offset.width / 10)) : .degrees(0))
                    .opacity(flag ? (2 - Double(abs(offset.width / 100))) : 1)
                    .offset(x: flag ? offset.width : 0, y: 0)
                    .gesture(
                        DragGesture()
                            .onChanged({ drag in
                                offset = drag.translation
                            })
                            .onEnded { _ in
                                if abs(offset.width) > 100 {
                                    removeAction?()
                                }
                                offset = .zero
                            }
                    )
            }
        }
    }
    
    struct DominoTile: View {
        let frame = CGSize(width: UIDevice.current.userInterfaceIdiom == .pad ? 400 : UIScreen.main.bounds.width <= 375 ? 325 : 375, height: 400)
        let profile: Profile
        let scale: CGFloat
        let detailed: Bool
        /// Configure the appearance of the stack. Use `true` to stagger views with an offset, `false` - default - on top of each other.
        var staggered = false
        let index: Int
        
        var body: some View {
            VStack {
                Tile(profile: profile, tileSize: frame)
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 1.0), value: scale)
                    .offset(x: staggered ? CGFloat(25 * index) : 0, y: 0)
                if detailed { Text(profile.profileInfo ?? "") }
            }
            .padding()
        }
    }
}

struct DominoStack_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DominoStack(data: UserStore().profiles, tileCount: 3) { }
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
                .previewDisplayName("iPhone 13 Pro Max")
            
            DominoStack(data: UserStore().profiles, tileCount: 3) { }
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
                .previewDisplayName("iPad Pro (11-inch) (4th generation)")
        }
    }
}
