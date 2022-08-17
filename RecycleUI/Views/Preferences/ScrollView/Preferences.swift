//
//  Preferences.swift
//  RecycleUI
//
//  Created by Yura on 8/16/22.
//

import SwiftUI

public struct ScrollOffsetPreferenceKey: PreferenceKey {
    public static var defaultValue: CGPoint = .zero
    
    public static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
