//
//  DiscoverUser.swift
//  Meliora
//
//  Created by Yura on 8/12/22.
//

import Foundation

struct DiscoverUser: EntityProfile, Identifiable {
    var id: Int?
    var profileInfo: String?
    var profilePhotoLocation: String?
    var status: Int8?
}

extension DiscoverUser: Codable { }

extension DiscoverUser: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id ?? 0)
    }
}
