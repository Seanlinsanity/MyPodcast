//
//  UserDefaults.swift
//  MyPodcast
//
//  Created by SEAN on 2018/6/3.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import Foundation

extension UserDefaults{
    
    static let favoritedPodcastKey = "favoritedPodcastKey"
    static let downloadEpisodesKey = "downloadEpisodesKey"
    
    func savedPodcasts() -> [Podcast]{
        guard let savedPodcastData = UserDefaults.standard.data(forKey: UserDefaults.favoritedPodcastKey) else { return []}
        guard let savedPodcasts = NSKeyedUnarchiver.unarchiveObject(with: savedPodcastData) as? [Podcast] else { return []}
        return savedPodcasts
    }
    
    func deletePodcast(podcast: Podcast) {
        let podcasts = savedPodcasts()
        let filteredPodcasts = podcasts.filter { (p) -> Bool in
            return p.trackName != podcast.trackName && p.artistName != podcast.artistName
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: filteredPodcasts)
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritedPodcastKey)
    }
    
    func downloadEpisode(episode: Episode){
        do{
            var episodes = downloadEpisodes()
            episodes.insert(episode, at: 0)
            let data = try JSONEncoder().encode(episodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadEpisodesKey)
            
        }catch let encodeErr{
            print("Failed to encode episode: ", encodeErr)
        }
    }
    
    func downloadEpisodes() -> [Episode]{
        guard let episodesData = data(forKey: UserDefaults.downloadEpisodesKey) else { return []}
        
        do{
            let episodes = try JSONDecoder().decode([Episode].self, from: episodesData)
            return episodes
        }catch let decodeErr{
            print("Failed to decode: ", decodeErr)
        }
        
        return []
    }
}



