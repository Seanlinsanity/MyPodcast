//
//  Podcast.m
//  Podcasts_ObjC
//
//  Created by SEAN on 2018/10/30.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "Podcast.h"

@implementation Podcast
- (id)initWithDictionary: (nullable NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.trackName = dict[@"trackName"];
        self.artistName = dict[@"artistName"];
        self.artworkUrl600 = dict[@"artworkUrl600"];
        self.trackCount = dict[@"trackCount"];
        self.feedUrl = dict[@"feedUrl"];
    }
    return self;
}

@end
