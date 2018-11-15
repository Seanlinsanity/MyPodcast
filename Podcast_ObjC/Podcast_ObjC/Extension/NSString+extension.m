//
//  NSString.m
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/6.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "NSString+extension.h"
#import <AVKit/AVKit.h>

@implementation NSString(extension)
- (NSString*)toSecureHTTPS {
    return [self containsString:@"https"] ? self : [self stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
}

+ (NSString*)displayStringWithTime: (CMTime)time {
    float totalSeconds = CMTimeGetSeconds(time);
    int totalSecondsInt = (int) totalSeconds;
    int seconds = totalSecondsInt % 60;
    int mins = totalSecondsInt / 60;
    
    NSString *timeFormatString = [[NSString alloc] initWithFormat:@"%02d:%02d", mins,seconds];
    return timeFormatString;
}
@end
