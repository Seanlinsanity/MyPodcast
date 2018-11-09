//
//  EpisodeCell.h
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/5.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Episode.h"

NS_ASSUME_NONNULL_BEGIN

@interface EpisodeCell : UITableViewCell
@property (strong, nonatomic) Episode *episode;
@property (strong, nonatomic) UIImageView *episodeImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@end

NS_ASSUME_NONNULL_END
