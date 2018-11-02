//
//  APIService.m
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/2.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "APIService.h"
#import "Alamofire-Swift.h"
#import "Podcast.h"

@implementation APIService

//singleton
+ (instancetype) sharedInstance {
    static APIService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[APIService alloc] init];
    });
    return instance;
}

- (void) fetchPodcastsWithSearchText: (NSString *)searchText withCompletion: (void(^)(NSMutableArray *podcasts)) completion {
    NSString *modifiedSearchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@", modifiedSearchText];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Search iTunes Error: %@", error.debugDescription);
            return;
        }
        
        NSError *jsonError;
        NSDictionary *searchResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if (jsonError) {
            NSLog(@"Json Error: %@", jsonError.debugDescription);
            return;
        }
        
//        NSNumber *count = searchResult[@"resultCount"];
        NSArray *results = searchResult[@"results"];
        NSMutableArray *podcasts = [NSMutableArray new];
        
        for (NSDictionary *result in results){
            Podcast *podcast = [[Podcast alloc] initWithName:result[@"trackName"] artistName:result[@"artistName"]];
            [podcasts addObject:podcast];
        }
        completion(podcasts);
        
    }] resume];
    
    NSLog(@"%@", urlString);
}


@end
