//
//  Podcast.m
//  Podcasts_ObjC
//
//  Created by SEAN on 2018/10/30.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "Podcast.h"

@implementation Podcast
- (id)initWithName: (nullable NSString*)trackName artistName: (nullable NSString*)artistName{
    self = [super init];
    if (self) {
        if (!trackName) {
            trackName = @"";
        }
        if (!artistName) {
            artistName = @"";
        }
        self.trackName = trackName;
        self.artistName = artistName;
    }
    return self;
}

@end
