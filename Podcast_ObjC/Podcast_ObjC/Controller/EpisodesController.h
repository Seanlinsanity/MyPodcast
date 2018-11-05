//
//  EpisodesController.h
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/5.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Podcast.h"
#import "MWFeedParser.h"
NS_ASSUME_NONNULL_BEGIN

@interface EpisodesController : UITableViewController<MWFeedParserDelegate>
@property (strong, nonatomic) Podcast *podcast;
@end

NS_ASSUME_NONNULL_END
