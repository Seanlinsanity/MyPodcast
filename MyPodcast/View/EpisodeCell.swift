//
//  EpisodeCell.swift
//  MyPodcast
//
//  Created by SEAN on 2018/4/3.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import UIKit
import SDWebImage

class EpisodeCell: UITableViewCell {
    
    var episode: Episode?{
        didSet{
            
            titleLabel.text = episode?.title
            descriptionLabel.text = episode?.description
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            pubDateLabel.text = dateFormatter.string(from: episode!.pubDate)
            
            let url = URL(string: episode!.imageUrl?.toSecureHTTPS() ?? "")
            episodeImageView.sd_setImage(with: url)
        
        }
    }

    let episodeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        return iv
    }()
    
    let pubDateLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .purple
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 2
        lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return lb
    }()
    
    let downloadProgressLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        lb.textColor = .white
        lb.textAlignment = .center
        lb.shadowColor = .black
        lb.shadowOffset = CGSize(width: 0, height: 1)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "0%"
        lb.isHidden = true
        return lb
    }()
    
    let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.numberOfLines = 2
        lb.textColor = .lightGray
        return lb
    }()
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        addSubview(episodeImageView)
        episodeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        episodeImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        episodeImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        episodeImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(downloadProgressLabel)
        downloadProgressLabel.centerXAnchor.constraint(equalTo: episodeImageView.centerXAnchor).isActive = true
        downloadProgressLabel.centerYAnchor.constraint(equalTo: episodeImageView.centerYAnchor).isActive = true
        downloadProgressLabel.widthAnchor.constraint(equalTo: episodeImageView.widthAnchor, constant: -16).isActive = true
        downloadProgressLabel.heightAnchor.constraint(equalTo: episodeImageView.heightAnchor).isActive = true
        
        
        let stackView = UIStackView(arrangedSubviews: [pubDateLabel, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: episodeImageView.rightAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }

}
