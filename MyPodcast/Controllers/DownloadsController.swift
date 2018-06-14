//
//  DownloadsController.swift
//  MyPodcast
//
//  Created by SEAN on 2018/6/13.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import UIKit

class DownloadsController: UITableViewController{
    
    fileprivate let cellId = "cellId"
    var episodes = UserDefaults.standard.downloadEpisodes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        episodes = UserDefaults.standard.downloadEpisodes()
        tableView.reloadData()
    }
    
    fileprivate func setupTableView(){
        
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: cellId)
    }
    
    //MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: episode, playlistEpisodes: episodes)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        cell.episode = episodes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
}
