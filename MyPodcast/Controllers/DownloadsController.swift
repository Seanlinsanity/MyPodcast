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
        setupObserver()
    }
    
    private func setupObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleDownloadProgress), name: .downloadProgress, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDownloadComplete), name: .downloadComplete, object: nil)
    }
    
    @objc private func handleDownloadComplete(notification: Notification){
        guard let episodeDownloadComplete = notification.object as? APIService.EpisodeDownloadCompleteTuple else { return }
        guard let index = episodes.index(where: {$0.title == episodeDownloadComplete.episodeTitle}) else { return }
        episodes[index].fileUrl = episodeDownloadComplete.fileUrl
    }
    
    @objc private func handleDownloadProgress(notification: Notification){
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let title = userInfo["title"] as? String else { return }
        guard let progress = userInfo["progress"] as? Double else { return }
        print(progress)
        
        guard let index = episodes.index(where: {$0.title == title}) else { return }
        updateDownloadEpisodeCell(index: index, progress: progress)
        
    }
    
    fileprivate func updateDownloadEpisodeCell(index: Int, progress: Double){
        let indexPath = IndexPath(row: index, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? EpisodeCell else { return }
        cell.downloadProgressLabel.text = "\(Int(progress * 100))%"
        cell.downloadProgressLabel.isHidden = false
        
        if progress == 1 {
            cell.downloadProgressLabel.isHidden = true
        }
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
        
        if episode.fileUrl != nil {
            UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: episode, playlistEpisodes: episodes)
        }else{
            let alertController = UIAlertController(title: "File URL not found", message: "Cannot find local file, play using stream url instead", preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            present(alertController, animated: true, completion: nil)
            
        }
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
