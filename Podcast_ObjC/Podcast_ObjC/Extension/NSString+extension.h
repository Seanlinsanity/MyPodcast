//
//  NSString.h
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/6.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString(extension)
- (NSString*)toSecureHTTPS;
+ (NSString*)displayStringWithTime: (CMTime)time;
@end

NS_ASSUME_NONNULL_END
