//
//  PlayDetailView.swift
//  MyPodcast
//
//  Created by SEAN on 2018/4/3.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class PlayerDetailView: UIView {
    
    var episode: Episode!{
        didSet{
            titleLabel.text = episode.title
            authorLabel.text = episode.author
            
            miniTitleLabel.text = episode.title
            
            playPauseButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
            miniPlayPauseButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
            
            setupAudioSession()
            playEpisode()
            
            setupNowPlayingInfo()
            
            guard let url = URL(string: episode.imageUrl?.toSecureHTTPS() ?? "") else { return }
            episodeImageView.sd_setImage(with: url, completed: nil)
            miniImageView.sd_setImage(with: url, completed: nil)
            
            miniImageView.sd_setImage(with: url) { (image, _, _, _) in
                let image = self.episodeImageView.image ?? UIImage()
                let artwork = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (_) -> UIImage in
                    return image
                })
                MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPMediaItemPropertyArtwork] = artwork
            }
            
        }
    }
    
    fileprivate func setupNowPlayingInfo(){
        
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = episode.title
        nowPlayingInfo[MPMediaItemPropertyArtist] = episode.author
        
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    private func playEpisode(){
        
        guard let url = URL(string: episode.streamUrl) else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    let player: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    let dismissBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Dismiss", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return btn
    }()
    
    let episodeImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .gray
        iv.layer.cornerRadius = 5
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let miniImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .gray
        iv.layer.cornerRadius = 5
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.numberOfLines = 2
        lb.text = "Title Here"
        return lb
    }()
    
    let miniTitleLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.text = "Title Here"
        return lb
    }()
    
    let authorLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.text = "Author"
        lb.textColor = .purple
        lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return lb
    }()
    
    let currentTimeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handleCurrentTimeSliderChange), for: .valueChanged)
        return slider
    }()
    
    let playPauseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        return btn
    }()
    
    let miniPlayPauseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        return btn
    }()
    
    let rewindButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "rewind15").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleRewind), for: .touchUpInside)
        return btn
    }()
    
    let forwardButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "fastforward15").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleFastForward), for: .touchUpInside)
        return btn
    }()
    
    let miniForwardButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "fastforward15").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(handleFastForward), for: .touchUpInside)
        return btn
    }()
    
    let mutedVolumeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "muted_volume").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let maxVolumeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "max_volume").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 1
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handleVolumeChange), for: .valueChanged)
        return slider
    }()
    
    let currentTimeLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.text = "00:00:00"
        lb.textColor = .lightGray
        lb.font = UIFont.systemFont(ofSize: 15)
        return lb
        
    }()
    
    let durationLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        lb.text = "00:00:00"
        lb.textColor = .lightGray
        lb.font = UIFont.systemFont(ofSize: 15)
        return lb
        
    }()
    
    fileprivate func seekToCurrentTime(delta: Int64){
        let fifteenSeconds = CMTimeMake(delta, 1)
        let seekTime = CMTimeAdd(player.currentTime(), fifteenSeconds)
        player.seek(to: seekTime)
    }
    
    @objc fileprivate func handleRewind(){
        seekToCurrentTime(delta: -15)
    }
    
    @objc fileprivate func handleFastForward(){
        seekToCurrentTime(delta: 15)
    }
    
    @objc fileprivate func handleCurrentTimeSliderChange(){
        
        let percentage = currentTimeSlider.value
        guard let duration = player.currentItem?.duration else { return }
        let seekTimeInSeconds = CMTimeGetSeconds(duration) * Float64(percentage)
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, 1)
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = seekTimeInSeconds
        
        
        player.seek(to: seekTime)
    }
    
    @objc fileprivate func handleVolumeChange(){
        player.volume = volumeSlider.value
    }
    
    fileprivate func enlargeEpisodeImageView(){
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.episodeImageView.transform = .identity
        }, completion: nil)
    }
    
    fileprivate let shrunkedTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    
    fileprivate func shrinkEpisodeImageView(){
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.episodeImageView.transform = self.shrunkedTransform
        }, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVAudioSessionInterruption, object: nil)
        print("PlayerDetailsView memory being reclaimed.")
    }
    
    @objc private func handlePlayPause(){
        
        if player.timeControlStatus == .paused{
            player.play()
            enlargeEpisodeImageView()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
            miniPlayPauseButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
            setupElapsedTime(playbackRate: 1)

        }else{
            player.pause()
            shrinkEpisodeImageView()
            playPauseButton.setImage(#imageLiteral(resourceName: "play").withRenderingMode(.alwaysOriginal), for: .normal)
            miniPlayPauseButton.setImage(#imageLiteral(resourceName: "play").withRenderingMode(.alwaysOriginal), for: .normal)
            setupElapsedTime(playbackRate: 0)
        }
    }
    
    @objc private func handleDismiss(){
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        mainTabBarController?.minimizePlayerDetails(episode: episode)

    }
    
    fileprivate func observePlayerStart(){
        let time = CMTimeMake(1, 3)
        let times = NSValue(time: time)
        player.addBoundaryTimeObserver(forTimes: [times], queue: .main) { [weak self] in
            self?.enlargeEpisodeImageView()
            self?.setupLockscreenDuration()
            
        }
    }
    
    fileprivate func setupLockscreenDuration(){
        guard let duration = player.currentItem?.duration else { return }
        let durationSeconds = CMTimeGetSeconds(duration)
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPMediaItemPropertyPlaybackDuration] = durationSeconds
    }
    
    fileprivate func observerPlayerCurrentTime(){
        let time = CMTimeMake(1, 2)
        
        player.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] (time) in

            self?.currentTimeLabel.text = time.toDisplayString()
            let duration = self?.player.currentItem?.duration
            self?.durationLabel.text = duration?.toDisplayString()
            
            self?.updateCurrentTimeSlider()
        }
    }
    
    fileprivate func updateCurrentTimeSlider(){
        
        let currentTimeSec = CMTimeGetSeconds(player.currentTime())
        let durationTimeSec = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(1, 1))
        let percentage = currentTimeSec / durationTimeSec
        
        currentTimeSlider.value = Float(percentage)
    }
    
    let miniPlayerView = UIView()
    
    private func setupMiniPlayerView(){
        
        miniPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(miniPlayerView)
        miniPlayerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        miniPlayerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        miniPlayerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        miniPlayerView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        let miniStackView = UIStackView(arrangedSubviews: [miniImageView, miniTitleLabel, miniPlayPauseButton, miniForwardButton])
        miniStackView.translatesAutoresizingMaskIntoConstraints = false
        miniPlayerView.addSubview(miniStackView)
        miniStackView.spacing = 8
        
        miniStackView.leftAnchor.constraint(equalTo: miniPlayerView.leftAnchor, constant: 8).isActive = true
        miniStackView.rightAnchor.constraint(equalTo: miniPlayerView.rightAnchor).isActive = true
        miniStackView.topAnchor.constraint(equalTo: miniPlayerView.topAnchor).isActive = true
        miniStackView.bottomAnchor.constraint(equalTo: miniPlayerView.bottomAnchor).isActive = true
        
        miniStackView.arrangedSubviews[0].widthAnchor.constraint(equalToConstant: 48).isActive = true
        miniStackView.arrangedSubviews[0].centerYAnchor.constraint(equalTo: miniPlayerView.centerYAnchor).isActive = true
        miniStackView.arrangedSubviews[0].heightAnchor.constraint(equalTo: miniPlayerView.heightAnchor, constant: -16).isActive = true
        miniStackView.arrangedSubviews[2].widthAnchor.constraint(equalToConstant: 48).isActive = true
        miniStackView.arrangedSubviews[3].widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        
        miniPlayerView.addSubview(seperatorView)
        seperatorView.topAnchor.constraint(equalTo: miniPlayerView.topAnchor).isActive = true
        seperatorView.leadingAnchor.constraint(equalTo: miniPlayerView.leadingAnchor).isActive = true
        seperatorView.trailingAnchor.constraint(equalTo: miniPlayerView.trailingAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
    private func setupGestures(){
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        miniPlayerView.addGestureRecognizer(panGesture)
        maximizedStackView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismissalPan)))
    }
    
    fileprivate func setupAudioSession(){
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

        }catch let sessionError{
            print("Failed to activate session:", sessionError)
        }
    }
    
    fileprivate func setupRemoteControl(){
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        
        commandCenter.playCommand.addTarget { (_) -> MPRemoteCommandHandlerStatus in
            self.player.play()
            self.setupElapsedTime(playbackRate: 1)
            self.playPauseButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
            self.miniPlayPauseButton.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysOriginal), for: .normal)
            return .success
        }
        commandCenter.pauseCommand.addTarget { (_) -> MPRemoteCommandHandlerStatus in
            self.player.pause()
            self.setupElapsedTime(playbackRate: 0)
            self.playPauseButton.setImage(#imageLiteral(resourceName: "play").withRenderingMode(.alwaysOriginal), for: .normal)
            self.miniPlayPauseButton.setImage(#imageLiteral(resourceName: "play").withRenderingMode(.alwaysOriginal), for: .normal)
            return .success
        }
        
        commandCenter.togglePlayPauseCommand.isEnabled = true
        commandCenter.togglePlayPauseCommand.addTarget { (_) -> MPRemoteCommandHandlerStatus in
            self.handlePlayPause()
            return .success
        }
        
        commandCenter.nextTrackCommand.addTarget(self, action: #selector(handleNextTrack))
        commandCenter.previousTrackCommand.addTarget(self, action: #selector(handlePreviousTrack))
    }
    
    var playlistEpisodes = [Episode]()
    var nextEpisode: Episode?

    @objc fileprivate func handlePreviousTrack(){
        if playlistEpisodes.count == 0 { return }
        
        let currentEpisodeIndex = playlistEpisodes.index(where: {$0.title == episode.title && $0.author == episode.author})
        guard let index = currentEpisodeIndex else { return }
        
        if index == 0{
            nextEpisode = playlistEpisodes[playlistEpisodes.count - 1]
        }else{
            nextEpisode = playlistEpisodes[index - 1]
        }
        
        self.episode = nextEpisode
    }
    
    @objc fileprivate func handleNextTrack(){
        if playlistEpisodes.count == 0 { return }
        
        let currentEpisodeIndex = playlistEpisodes.index(where: {$0.title == episode.title && $0.author == episode.author})
        guard let index = currentEpisodeIndex else { return }
        
        if index == playlistEpisodes.count - 1{
            nextEpisode = playlistEpisodes[0]
        }else{
           nextEpisode = playlistEpisodes[index + 1]
        }
        
        self.episode = nextEpisode
    }
    
    fileprivate func setupElapsedTime(playbackRate: Float){
        let elapsedTime = CMTimeGetSeconds(player.currentTime())
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = elapsedTime
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyPlaybackRate] = playbackRate
    }
    
    fileprivate func setupInterruptionObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption), name: .AVAudioSessionInterruption, object: nil)
    }
    
    @objc fileprivate func handleInterruption(notification: Notification){
        guard let userInfo = notification.userInfo else { return }
        guard let type = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt else { return }
        
        if type == AVAudioSessionInterruptionType.began.rawValue {
            print("Interruption began")
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            miniPlayPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }else{
            print("Interruption ended...")
            guard let options = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
            if options == AVAudioSessionInterruptionOptions.shouldResume.rawValue {
                player.play()
                handlePlayPause()
            }
        }
        
    }
    
    let maximizedStackView = UIStackView()
    var panGesture: UIPanGestureRecognizer!
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        
        setupRemoteControl()
        setupGestures()
        setupInterruptionObserver()
        
        observePlayerStart()
        observerPlayerCurrentTime()
        
        setupMiniPlayerView()
        setupMaxPlayerView()
    }
    
    private func setupMaxPlayerView(){
        
        let controlStackView = UIStackView(arrangedSubviews: [rewindButton, playPauseButton, forwardButton])
        controlStackView.distribution = .fillEqually
        
        let timeStackView = UIStackView(arrangedSubviews: [currentTimeLabel, durationLabel])
        
        let volumeControlStackView = UIStackView(arrangedSubviews: [mutedVolumeButton, volumeSlider, maxVolumeButton])
        volumeControlStackView.distribution = .fill
        volumeControlStackView.arrangedSubviews[0].widthAnchor.constraint(equalToConstant: 34)
        volumeControlStackView.arrangedSubviews[2].widthAnchor.constraint(equalToConstant: 34)
        
        
        let maximizedStackViewSubviews: [UIView] = [dismissBtn, episodeImageView, currentTimeSlider, timeStackView, titleLabel, authorLabel, controlStackView, volumeControlStackView]
        
        maximizedStackViewSubviews.forEach { (view) in
            maximizedStackView.addArrangedSubview(view)
        }
        maximizedStackView.translatesAutoresizingMaskIntoConstraints = false
        maximizedStackView.axis = .vertical
        
        addSubview(maximizedStackView)
        maximizedStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        maximizedStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        maximizedStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        maximizedStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24).isActive = true
        
        maximizedStackView.arrangedSubviews[0].heightAnchor.constraint(equalToConstant: 40).isActive = true
        maximizedStackView.arrangedSubviews[1].heightAnchor.constraint(equalTo: widthAnchor, constant: -48).isActive = true
        maximizedStackView.arrangedSubviews[2].heightAnchor.constraint(equalToConstant: 36).isActive = true
        maximizedStackView.arrangedSubviews[3].heightAnchor.constraint(equalToConstant: 22).isActive = true
        maximizedStackView.arrangedSubviews[4].heightAnchor.constraint(equalToConstant: 48).isActive = true
        maximizedStackView.arrangedSubviews[5].heightAnchor.constraint(equalToConstant: 36).isActive = true
        maximizedStackView.arrangedSubviews[7].heightAnchor.constraint(equalToConstant: 34).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
