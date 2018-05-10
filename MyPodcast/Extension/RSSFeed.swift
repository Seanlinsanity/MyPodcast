//
//  RSSFeed.swift
//  MyPodcast
//
//  Created by SEAN on 2018/4/3.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import FeedKit

extension RSSFeed{
    
    func toEpisodes() -> [Episode] {
        
        let imageUrl = iTunes?.iTunesImage?.attributes?.href
        
        var episodes = [Episode]()
        
        items?.forEach({ (feedItem) in
            var episode = Episode(feedItem: feedItem)
            
            if episode.imageUrl == nil {
                episode.imageUrl = imageUrl
            }
            episodes.append(episode)
        })
        return episodes
    }
}
