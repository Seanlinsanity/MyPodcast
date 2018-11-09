//
//  Episode.m
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/5.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "Episode.h"

@implementation Episode

- (id)initWithFeed: (MWFeedItem *)item {
    self = [super init];
    if (self) {
        self.title = item.title;
        self.date = item.date;
        self.content = item.summary;
    }
    return self;
}


@end
