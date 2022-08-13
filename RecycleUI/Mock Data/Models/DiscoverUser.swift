//
//  DiscoverUser.swift
//  Meliora
//
//  Created by Yura on 8/12/22.
//

import Foundation

struct DiscoverUser: DominoProfile {
    var id: Int?
    var profileInfo: String?
    var profilePhotoLocation: String?
    var status: Int8?
}

public enum DiscoverStatus: Int8 {
    case visible = 0, incognito
}

extension DiscoverUser: Codable { }

extension DiscoverUser: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id ?? 0)
    }
}
