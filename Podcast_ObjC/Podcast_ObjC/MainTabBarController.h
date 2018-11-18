//
//  MainTabBarController.h
//  Podcasts_ObjC
//
//  Created by SEAN on 2018/10/30.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Episode.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainTabBarController : UITabBarController
- (void)minimizePlayerDetailsView;
- (void)maximizePlayerDetailsViewWithEpisode: (Episode* _Nullable)episode;
@end

NS_ASSUME_NONNULL_END
