//
//  UserStore.swift
//  RecycleUI
//
//  Created by Yura on 8/13/22.
//

import Foundation

struct UserStore {
    var images: [String]
    var profiles: [DiscoverUser]
    var info: [String?]
    
    init() {
        info = [
            nil,
            "I am a big literature enthusiast. I love Pushkin, Tolstoy, Mitchell.",
            "There is nothing better than having felt all the possible emotions available to us.",
            "I really like her. I think it will be super hard with her, but, perhaps, I can mold her into being my woman.",
            "I want to travel more and see other great places full of history.",
            "I am Stan. I am 34. I stream from my mother's basement and touch myself at night.",
            "Yesterday I saw a beautiful moon rise. A fiery ball of light came out of the horizon around 9. I will be streaming more spectacular events like this!"
        ]
        images = [
            "https://cdn.pixabay.com/photo/2022/07/25/10/19/mountain-7343375_960_720.jpg",
            "https://cdn.pixabay.com/photo/2016/08/11/23/48/mountains-1587287_960_720.jpg",
            "https://cdn.pixabay.com/photo/2015/07/09/22/45/tree-838667_960_720.jpg",
            "https://cdn.pixabay.com/photo/2022/07/18/11/21/large-star-umbel-7329595_960_720.jpg",
            "https://cdn.pixabay.com/photo/2016/11/14/03/46/girl-1822525_960_720.jpg",
            "https://cdn.pixabay.com/photo/2022/07/22/13/23/coast-7338147_960_720.jpg",
            "https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989_960_720.jpg"
        ]
        profiles = [
            DiscoverUser(id: 1, profileInfo: info[0], profilePhotoLocation: images[0]),
            DiscoverUser(id: 2, profileInfo: info[1], profilePhotoLocation: images[1]),
            DiscoverUser(id: 3, profileInfo: info[2], profilePhotoLocation: images[2]),
            DiscoverUser(id: 4, profileInfo: info[3], profilePhotoLocation: images[3]),
            DiscoverUser(id: 5, profileInfo: info[4], profilePhotoLocation: images[4]),
            DiscoverUser(id: 6, profileInfo: info[5], profilePhotoLocation: images[5]),
            DiscoverUser(id: 7, profileInfo: info[6], profilePhotoLocation: images[6])
        ]
    }
}
