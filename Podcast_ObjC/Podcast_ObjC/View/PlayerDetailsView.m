//
//  PlayerDetailsView.m
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/9.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "PlayerDetailsView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AVKit/AVKit.h>

@interface PlayerDetailsView()
@property (strong, nonatomic) AVPlayer *player;
@end

@implementation PlayerDetailsView
static CGFloat shrinkScale = 0.7;

- (void)setEpisode:(Episode *)episode {
    _episode = episode;
    self.titleLabel.text = episode.title;
    self.authorLabel.text = episode.author;
    [self.episodeImageView sd_setImageWithURL:[[NSURL alloc]initWithString:episode.imageUrl]];
    self.episodeImageView.transform = CGAffineTransformScale(self.episodeImageView.transform, shrinkScale, shrinkScale);
    [self playEpisode];
}

- (void)enlargeEpisodeImageView {
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.episodeImageView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)shrinkEpisodeImageView {
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.episodeImageView.transform = CGAffineTransformScale(self.episodeImageView.transform, shrinkScale, shrinkScale);
    } completion:nil];
}

- (void)playEpisode {
    NSURL *url = [NSURL URLWithString:self.episode.streamUrl];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self.player play];
}

- (void)handlePlayPause {
    if (self.player.timeControlStatus == AVPlayerTimeControlStatusPaused){
        [self.player play];
        [self.playPauseButton setImage:[[UIImage imageNamed:@"pause"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self enlargeEpisodeImageView];
    }else{
        [self.playPauseButton setImage:[[UIImage imageNamed:@"play"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.player pause];
        [self shrinkEpisodeImageView];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initComponents];
        [self setupUI];
        
        CMTime time = CMTimeMake(1, 3);
        NSArray *times = @[[NSValue valueWithCMTime:time]];
        __weak PlayerDetailsView *wSelf = self;

        [self.player addBoundaryTimeObserverForTimes:times queue:dispatch_get_main_queue() usingBlock:^{
            NSLog(@"start playing...");
            [wSelf enlargeEpisodeImageView];
        }];
        
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = UIColor.whiteColor;
    
    [self.dismissButton.heightAnchor constraintEqualToConstant:44].active = YES;
    [self.episodeImageView.heightAnchor constraintEqualToAnchor:self.episodeImageView.widthAnchor multiplier:1].active = YES;
    [self.slider.heightAnchor constraintEqualToConstant:40].active = YES;
    [self.titleLabel.heightAnchor constraintGreaterThanOrEqualToConstant:20].active = YES;
    [self.authorLabel.heightAnchor constraintEqualToConstant:20].active = YES;
    
    UIStackView *timeStackView = [[UIStackView alloc] initWithArrangedSubviews:[[NSArray alloc]initWithObjects:self.currentTimeLabel, self.durationLabel, nil]];
    timeStackView.axis = UILayoutConstraintAxisHorizontal;
    timeStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [timeStackView.heightAnchor constraintEqualToConstant:24].active = YES;
    
    UIStackView *buttonStackView = [[UIStackView alloc] initWithArrangedSubviews:[[NSArray alloc]initWithObjects:self.rewindButton, self.playPauseButton, self.forwardButton, nil]];
    buttonStackView.axis = UILayoutConstraintAxisHorizontal;
    buttonStackView.translatesAutoresizingMaskIntoConstraints = NO;
    buttonStackView.distribution = UIStackViewDistributionFillProportionally;
    [buttonStackView.heightAnchor constraintEqualToConstant:200].active = YES;

    UIStackView *volumeStackView = [[UIStackView alloc] initWithArrangedSubviews:[[NSArray alloc]initWithObjects:self.mutedVolumeImage, self.volumeSlider, self.maxVolumeImage, nil]];
    volumeStackView.translatesAutoresizingMaskIntoConstraints = NO;
    volumeStackView.axis = UILayoutConstraintAxisHorizontal;
    volumeStackView.distribution = UIStackViewDistributionFill;
    [volumeStackView.heightAnchor constraintEqualToConstant:36].active = YES;

    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:[[NSArray alloc]initWithObjects:self.dismissButton, self.episodeImageView, self.slider, timeStackView, self.titleLabel, self.authorLabel, buttonStackView, volumeStackView, nil]];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:stackView];
    [stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:24].active = YES;
    [stackView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:0].active = YES;
    [stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-24].active = YES;
    [stackView.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor constant:-24].active = YES;
    
}

- (void)handleDismiss {
    [self removeFromSuperview];
}

- (void)initComponents {
    self.dismissButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"Dismiss" forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [btn addTarget:self action:@selector(handleDismiss) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    self.episodeImageView = ({
        UIImageView *iv = [UIImageView new];
        iv.image = [UIImage imageNamed:@"appicon"];
        iv.translatesAutoresizingMaskIntoConstraints = NO;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.layer.cornerRadius = 8;
        iv.clipsToBounds = YES;
        iv;
    });
    
    self.titleLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"Track Name Here";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.font = [UIFont boldSystemFontOfSize:20];
        label;
    });
    
    self.authorLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"Author";
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
        label.textColor = UIColor.purpleColor;
        label;
    });
    
    self.slider = ({
        UISlider *slider = [UISlider new];
        slider.translatesAutoresizingMaskIntoConstraints = NO;
        slider;
    });
    
    self.playPauseButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setImage:[[UIImage imageNamed:@"pause"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [btn addTarget:self action:@selector(handlePlayPause) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    self.rewindButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setImage:[[UIImage imageNamed:@"rewind"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        btn;
    });
    
    self.forwardButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setImage:[[UIImage imageNamed:@"fastforward"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        btn;
    });
    
    self.volumeSlider = ({
        UISlider *slider = [UISlider new];
        slider.translatesAutoresizingMaskIntoConstraints = NO;
        slider;
    });
    
    self.maxVolumeImage = ({
        UIImageView *iv = [UIImageView new];
        iv.image = [UIImage imageNamed:@"max_volume"];
        iv.translatesAutoresizingMaskIntoConstraints = NO;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv;
    });
    
    self.mutedVolumeImage = ({
        UIImageView *iv = [UIImageView new];
        iv.image = [UIImage imageNamed:@"muted_volume"];
        iv.translatesAutoresizingMaskIntoConstraints = NO;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv;
    });
    
    self.currentTimeLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"00:00:000";
        label.font = [UIFont systemFontOfSize:16];
        label;
    });
    
    self.durationLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"88:88:88";
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:16];
        label;
    });
    
    self.player = ({
        AVPlayer *player = [AVPlayer new];
        player.automaticallyWaitsToMinimizeStalling = NO;
        player;
    });
    
}

@end
