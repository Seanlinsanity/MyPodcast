//
//  Episode.m
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/5.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "Episode.h"

@implementation Episode
- (id)initWithTitle: (NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

@end
