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
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(handleSaveFavorite)),
            UIBarButtonItem(title: "Fetch", style: .plain, target: self, action: #selector(handleFetchSavedPodcasts)),

        ]
    }
    
    let favoritedPodcastKey = "favortiedPodcastKey"
    @objc fileprivate func handleSaveFavorite(){
        
        guard let podcast = self.podcast else { return }
        //1. Transform Podcast into Data
        let data = NSKeyedArchiver.archivedData(withRootObject: podcast)
        
        UserDefaults.standard.set(data, forKey: favoritedPodcastKey)
    }
    
    @objc fileprivate func handleFetchSavedPodcasts(){
        guard let data = UserDefaults.standard.data(forKey: favoritedPodcastKey) else { return }
        let podcast = NSKeyedUnarchiver.unarchiveObject(with: data) as? Podcast
        print(podcast?.trackName)
    }
    
    fileprivate func setupTableView(){
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- UITableView
    
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
