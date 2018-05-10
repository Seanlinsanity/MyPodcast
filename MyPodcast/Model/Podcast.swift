//
//  Podcast.swift
//  MyPodcast
//
//  Created by SEAN on 2018/4/2.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import UIKit

struct Podcast: Decodable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
}
