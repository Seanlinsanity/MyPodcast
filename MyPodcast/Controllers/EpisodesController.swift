//
//  EpisodesController.swift
//  MyPodcast
//
//  Created by SEAN on 2018/4/3.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import UIKit
import FeedKit


class EpisodesController: UITableViewController{
    
    var podcast: Podcast?{
        didSet{
            navigationItem.title = podcast?.trackName
            fetchEpisodes()
        }
    }
    
    fileprivate func fetchEpisodes(){
        
        guard let feedUrl = podcast?.feedUrl else { return }
        
        APIService.shared.fetchEpisode(feedUrl: feedUrl) { (episodes) in
            self.episodes = episodes
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var episodes = [Episode]()
    
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBarButtons()
    }
    
    //MARK:- Setup work
    
    fileprivate func setupNavigationBarButtons(){
        
        let savedPodcasts = UserDefaults.standard.savedPodcasts()
        let hasFavorited = savedPodcasts.index(where: {$0.trackName == self.podcast?.trackName && $0.artistName == self.podcast?.artistName}) != nil
        
        if hasFavorited{
            
            navigationItem.rightBarButtonItem  = UIBarButtonItem(image: #imageLiteral(resourceName: "heart"), style: .plain, target: nil, action: nil)
        }else{
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(handleSaveFavorite)),
//                UIBarButtonItem(title: "Fetch", style: .plain, target: self, action: #selector(handleFetchSavedPodcasts)),
            ]
        }
    
    }
    
    @objc fileprivate func handleSaveFavorite(){
        
        guard let podcast = self.podcast else { return }
        
//        guard let data = UserDefaults.standard.data(forKey: favoritedPodcastKey) else { return }
//        let savedPodcasts = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Podcast]
        
        let savedPodcasts = UserDefaults.standard.savedPodcasts()
        
        //Transform Podcast into Data
        
        var listOfPodcasts = savedPodcasts
        listOfPodcasts.append(podcast)
        let data = NSKeyedArchiver.archivedData(withRootObject: listOfPodcasts)
        
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritedPodcastKey)
        
        showBadgeHighlight()
        navigationItem.rightBarButtonItem  = UIBarButtonItem(image: #imageLiteral(resourceName: "heart"), style: .plain, target: nil, action: nil)
    }
    
    fileprivate func showBadgeHighlight(){
        UIApplication.mainTabBarController()?.viewControllers?[1].tabBarItem.badgeValue = "New"
    }
    
    @objc fileprivate func handleFetchSavedPodcasts(){
        let savedPodcasts = UserDefaults.standard.savedPodcasts()

        savedPodcasts.forEach({ (podcast) in
            print(podcast.trackName)
        })
    }
    
    fileprivate func setupTableView(){
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let downloadAction = UITableViewRowAction(style: .normal, title: "Download") { (_, _) in

            let episode = self.episodes[indexPath.row]
            UserDefaults.standard.downloadEpisode(episode: episode)
            
            APIService.shared.downloadEpisode(episode: episode)
        }
        
        return [downloadAction]
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return episodes.isEmpty ? 200 : 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        mainTabBarController?.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)

        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        cell.episode = episode
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
}
