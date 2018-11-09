//
//  NSString.m
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/6.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "NSString_http.h"

@implementation NSString(http)
- (NSString*)toSecureHTTPS {
    return [self containsString:@"https"] ? self : [self stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
}
@end
