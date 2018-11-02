//
//  APIService.h
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/2.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIService : NSObject
+ (instancetype) sharedInstance;
- (void) fetchPodcastsWithSearchText: (NSString *)searchText withCompletion: (void(^)(NSMutableArray *podcasts)) completion;
@end;

NS_ASSUME_NONNULL_END
