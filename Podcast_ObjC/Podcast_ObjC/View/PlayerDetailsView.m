//
//  PlayerDetailsView.m
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/9.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "PlayerDetailsView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PlayerDetailsView

- (void)setEpisode:(Episode *)episode {
    self.titleLabel.text = episode.title;
    [self.episodeImageView sd_setImageWithURL:[[NSURL alloc]initWithString:episode.imageUrl]];
    _episode = episode;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initComponents];
        [self setupUI];
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
    
    UIStackView *buttonStackView = [[UIStackView alloc] initWithArrangedSubviews:[[NSArray alloc]initWithObjects:self.rewindButton, self.playButton, self.forwardButton, nil]];
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
        iv;
    });
    
    self.titleLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"Track Name Here";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.font = [UIFont boldSystemFontOfSize:18];
        label;
    });
    
    self.authorLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"Author";
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
        label.textColor = UIColor.purpleColor;
        label;
    });
    
    self.slider = ({
        UISlider *slider = [UISlider new];
        slider.translatesAutoresizingMaskIntoConstraints = NO;
        slider;
    });
    
    self.playButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setImage:[[UIImage imageNamed:@"play"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
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
    
}

@end
