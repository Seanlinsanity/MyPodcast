//
//  PlayerDetailsView.h
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/9.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Episode.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayerDetailsView : UIView
@property (strong, nonatomic) UIButton *dismissButton;
@property (strong, nonatomic) UIImageView *episodeImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UISlider *timeSlider;
@property (strong, nonatomic) UIButton *playPauseButton;
@property (strong, nonatomic) UIButton *rewindButton;
@property (strong, nonatomic) UIButton *forwardButton;
@property (strong, nonatomic) UISlider *volumeSlider;
@property (strong, nonatomic) UIImageView *maxVolumeImage;
@property (strong, nonatomic) UIImageView *mutedVolumeImage;
@property (strong, nonatomic) UILabel *currentTimeLabel;
@property (strong, nonatomic) UILabel *durationLabel;

@property (strong, nonatomic) Episode * _Nullable episode;
@end

NS_ASSUME_NONNULL_END
