//
//  PodcastCell.h
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/2.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Podcast.h"

NS_ASSUME_NONNULL_BEGIN

@interface PodcastCell : UITableViewCell
@property (strong, nonatomic) UIImageView *podcastImageView;
@property (strong, nonatomic) UILabel *trackNameLabel;
@property (strong, nonatomic) UILabel *artistNameLabel;
@property (strong, nonatomic) UILabel *episodeCountLabel;
@property (strong, nonatomic) Podcast *podcast;
@end

NS_ASSUME_NONNULL_END
