//
//  UIApplication.swift
//  MyPodcast
//
//  Created by SEAN on 2018/5/22.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static func mainTabBarController() -> MainTabBarController? {
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
    
}
