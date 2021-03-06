//
//  PlayerDetailView+Gestures.swift
//  MyPodcast
//
//  Created by SEAN on 2018/5/22.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import UIKit

extension PlayerDetailView {
    @objc func handleTap(){
        UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: nil)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        
        if gesture.state == .changed{
            handlePanChanged(gesture: gesture)
        }else if gesture.state == .ended{
            handlePanEnded(gesture: gesture)
        }
    }
    
    func handlePanChanged(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: self.superview)
        print(translation.x, translation.y)
        self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        self.miniPlayerView.alpha = 1 + translation.y / 200
        self.maximizedStackView.alpha = -translation.y / 200
    }
    
    @objc func handleDismissalPan(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: superview)
        
        if gesture.state == .changed {
            maximizedStackView.transform = CGAffineTransform(translationX: 0, y: translation.y)
        }else if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.maximizedStackView.transform = .identity
                
                if translation.y > 100 {
                    UIApplication.mainTabBarController()?.minimizePlayerDetails(episode: nil)
                }
                
            }, completion: nil)
        }
        
    }
    
    func handlePanEnded(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: self.superview)
        let velocity = gesture.velocity(in: self.superview)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.transform = .identity
            
            if translation.y < -200 || velocity.y < -500 {
                UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: nil)
            }else{
                
                self.miniPlayerView.alpha = 1
                self.maximizedStackView.alpha = 0
            }
            
        }, completion: nil)
    }
    
}
