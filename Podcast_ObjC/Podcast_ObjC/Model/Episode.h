//
//  Episode.h
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/5.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Episode : NSObject
@property (strong, nonatomic) NSString *title;
- (id)initWithTitle: (NSString *)title;
@end

NS_ASSUME_NONNULL_END
