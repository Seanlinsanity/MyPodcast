//
//  Podcast.h
//  Podcasts_ObjC
//
//  Created by SEAN on 2018/10/30.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Podcast : NSObject
@property (nonatomic, strong) NSString *trackName;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *artworkUrl600;
@property (nonatomic, strong) NSNumber *trackCount;
@property (nonatomic, strong) NSString *feedUrl;
- (id)initWithDictionary: (nullable NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END
