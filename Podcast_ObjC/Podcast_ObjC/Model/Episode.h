//
//  Episode.h
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/5.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWFeedParser.h"

NS_ASSUME_NONNULL_BEGIN

@interface Episode : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *streamUrl;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *author;
- (id)initWithFeed: (MWFeedItem *)item;
@end

NS_ASSUME_NONNULL_END
