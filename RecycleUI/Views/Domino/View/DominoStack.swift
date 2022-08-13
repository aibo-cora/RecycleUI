//
//  DominoStack.swift
//  RecycleUI
//
//  Created by Yura on 8/13/22.
//

import SwiftUI

public protocol DominoProfile: Hashable {
    var profileInfo: String? { get set }
    var profilePhotoLocation: String? { get set }
}
/**
 A view composed of individual tiles stacked together in a `ZStack`.
 - Author:
 Yura
 - parameters:
    - data: array, whose elements conform to the `DominoProfile` protocol.
    - tileCount: will be used to specify how many views will be displayed in a stack.
    - removeAction: closure will execute if the top tile is dragged to either side by more than `100` points and released.
 - Important:
 If the `profilePhotoLocation` has an invalid URL, the tile will display a continuous activity indicator. Provide a default URL with a backup image.
 - Version:
 1.0
 
 Animation to bring up the next tile after the top one was removed.
 */
public struct DominoStack<Profile>: View where Profile: DominoProfile {
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
        VStack {
            ScrollView(showsIndicators: false) {
                ZStack {
                    ForEach(Array(data.enumerated()), id: \.element) { index, profile in
                        if index < tileCount {
                            DominoTile(defaultProfilePhotoLocation: defaultProfilePhotoLocation, index: index, scale: 1 - 0.1 * CGFloat(index), profile: profile)
                                .zIndex(-Double(index))
                                .rotationEffect(index == 0 ? .degrees(Double(offset.width / 10)) : .degrees(0))
                                .opacity(index == 0 ? (2 - Double(abs(offset.width / 100))) : 1)
                                .offset(x: index == 0 ? offset.width : 0, y: 0)
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
                
            }
        }
    }
    
    /// Single domino tile.
    struct DominoTile: View {
        let defaultProfilePhotoLocation: String
        let size: CGSize = .init(width: UIDevice.current.userInterfaceIdiom == .pad ? 400 : UIScreen.main.bounds.width <= 375 ? 325 : 375, height: 400)
        
        let index: Int
        let scale: CGFloat
        let profile: Profile
        
        var body: some View {
            VStack {
                AsyncImage(url: URL(string: profile.profilePhotoLocation ?? defaultProfilePhotoLocation)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()/// Use colorScheme to hide the 3 spinners.
                }
                .frame(width: self.size.width, height: self.size.height)
                .cornerRadius(25)
                .scaleEffect(scale)
                .offset(x: CGFloat(25 * index), y: 0)
                .animation(.easeInOut(duration: 1.0), value: scale)
                
                if index == 0 {
                    Text(profile.profileInfo ?? "I am still considering a good intro for this.")
                        .frame(width: self.size.width + 25)
                        .padding()
                } else {
                    Spacer()
                }
            }
        }
    }
}

struct DominoStack_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DominoStack(data: UserStore().discoverUsers, tileCount: 3) {
                
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")
            
            DominoStack(data: UserStore().discoverUsers, tileCount: 3) {
                
            }
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (3rd generation)"))
            .previewDisplayName("iPad Pro (11-inch) (3rd generation)")
        }
    }
}
