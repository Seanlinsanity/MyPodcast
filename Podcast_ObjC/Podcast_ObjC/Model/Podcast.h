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
- (id)initWithName: (nullable NSString*)trackName artistName: (nullable NSString*)artistName;
@end

NS_ASSUME_NONNULL_END
