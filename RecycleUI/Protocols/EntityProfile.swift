//
//  EntityProfile.swift
//  RecycleUI
//
//  Created by Yura on 8/17/22.
//

import Foundation

public protocol EntityProfile: Hashable {
    var profileInfo: String? { get set }
    var profilePhotoLocation: String? { get set }
}
