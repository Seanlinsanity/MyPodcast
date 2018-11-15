//
//  PodcastCell.m
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/2.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "PodcastCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+extension.h"

@implementation PodcastCell

- (void)setPodcast:(Podcast *)podcast {
    self.trackNameLabel.text = podcast.trackName;
    self.artistNameLabel.text = podcast.artistName;
    self.episodeCountLabel.text = [[NSString alloc] initWithFormat:@"%ld Episodes", (long)podcast.trackCount.integerValue];
    NSURL *url = [[NSURL alloc] initWithString:[podcast.artworkUrl600 toSecureHTTPS]];
    [self.podcastImageView sd_setImageWithURL:url completed:nil];
    _podcast = podcast;
}

- (void)initUIComponents {
    self.podcastImageView = ({
        UIImageView *iv = [UIImageView new];
        iv.translatesAutoresizingMaskIntoConstraints = NO;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.backgroundColor = UIColor.lightGrayColor;
        iv;
    });
    
    self.trackNameLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"Track Name Here";
        label.font = [UIFont boldSystemFontOfSize:18];
        label.numberOfLines = 2;
        label;
    });
    
    self.artistNameLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"Artist Name Here";
        label.font = [UIFont systemFontOfSize:16];
        label;
    });
    
    self.episodeCountLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"Episode Count Here";
        label.textColor = UIColor.darkGrayColor;
        label.font = [UIFont systemFontOfSize:15];
        label;
    });
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self){
        [self initUIComponents];
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI {
    [self addSubview:self.podcastImageView];
    [self.podcastImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:16].active = YES;
    [self.podcastImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:16].active = YES;
    [self.podcastImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-16].active = YES;
    [self.podcastImageView.heightAnchor constraintEqualToConstant:100].active = YES;
    [self.podcastImageView.widthAnchor constraintEqualToAnchor:self.podcastImageView.heightAnchor].active = YES;
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:[[NSArray alloc] initWithObjects:self.trackNameLabel, self.artistNameLabel, self.episodeCountLabel, nil]];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.distribution = UIStackViewDistributionFillProportionally;
    stackView.spacing = 4;
    stackView.axis = UILayoutConstraintAxisVertical;
    [self addSubview:stackView];
    [stackView.leftAnchor constraintEqualToAnchor:self.podcastImageView.rightAnchor constant:8].active = YES;
    [stackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [stackView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant: -8].active = YES;
}

@end
