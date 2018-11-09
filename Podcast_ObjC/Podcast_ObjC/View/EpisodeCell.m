//
//  EpisodeCell.m
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/5.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "EpisodeCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation EpisodeCell

- (void)setEpisode:(Episode *)episode {
    self.titleLabel.text = episode.title;
    self.descriptionLabel.text = episode.content;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"MMM dd, yyyy";
    self.dateLabel.text = [dateFormatter stringFromDate:episode.date];
    
    [self.episodeImageView sd_setImageWithURL:[[NSURL alloc]initWithString:episode.imageUrl] completed:nil];
    
    _episode = episode;
}

- (void)initUIComponents {
    self.episodeImageView = ({
        UIImageView *iv = [UIImageView new];
        iv.image = [UIImage imageNamed:@"appicon"];
        iv.translatesAutoresizingMaskIntoConstraints = NO;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.backgroundColor = UIColor.lightGrayColor;
        iv.layer.cornerRadius = 4;
        iv.layer.masksToBounds = YES;
        iv;
    });
    
    self.titleLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"Track Name Here";
        label.font = [UIFont boldSystemFontOfSize:18];
        label.numberOfLines = 2;
        label;
    });
    
    self.dateLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"Date";
        label.textColor = UIColor.purpleColor;
        label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
        label;
    });
    
    self.descriptionLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"Description";
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 2;
        label;
    });
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUIComponents];
        
        [self addSubview:self.episodeImageView];
        [self.episodeImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        [self.episodeImageView.widthAnchor constraintEqualToConstant:100].active = YES;
        [self.episodeImageView.heightAnchor constraintEqualToAnchor:self.episodeImageView.widthAnchor].active = YES;
        [self.episodeImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:16].active = YES;
        
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews: [[NSArray alloc] initWithObjects:self.dateLabel, self.titleLabel, self.descriptionLabel, nil]];
        stackView.translatesAutoresizingMaskIntoConstraints = NO;
        stackView.axis = UILayoutConstraintAxisVertical;
        stackView.distribution = UIStackViewDistributionFillProportionally;
    
        [self addSubview:stackView];
        [stackView.leftAnchor constraintEqualToAnchor:self.episodeImageView.rightAnchor constant:16].active = YES;
        [stackView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        [stackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:0].active = YES;
        
    }
    
    return self;
}


@end
