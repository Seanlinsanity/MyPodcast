//
//  EpisodesController.m
//  Podcast_ObjC
//
//  Created by SEAN on 2018/11/5.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "EpisodesController.h"
#import "Episode.h"
#import "MWFeedParser.h"
#import "EpisodeCell.h"
#import "NSString+extension.h"
#import "PlayerDetailsView.h"
#import "MainTabBarController.h"

@interface EpisodesController ()
@property (strong, nonatomic) NSMutableArray *episodes;
@end

@implementation EpisodesController
static NSString *cellId = @"cellId";

- (void)setPodcast:(Podcast *)podcast{
    self.navigationItem.title = podcast.trackName;
    [self parseEpisodesFeedUrlWith:podcast.feedUrl];
    _podcast = podcast;
}

- (void) parseEpisodesFeedUrlWith: (NSString *)feedUrl {
    NSString *urlString = [feedUrl toSecureHTTPS];
    NSURL *url = [NSURL URLWithString:urlString];
    MWFeedParser *feedParser = [[MWFeedParser alloc] initWithFeedURL:url];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeAsynchronously;
    if (self.episodes) {
        [self.episodes removeAllObjects];
    }else{
        self.episodes = [NSMutableArray new];
    }
    [feedParser parse];
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    Episode *episode = [[Episode alloc] initWithFeed:item];
    episode.imageUrl = self.podcast.artworkUrl600;
    episode.author = self.podcast.artistName;
    [self.episodes addObject:episode];

}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:EpisodeCell.self forCellReuseIdentifier:cellId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.episodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EpisodeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    Episode *episode = self.episodes[indexPath.row];
    cell.episode = episode;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTabBarController *mainTabBarController = (MainTabBarController*)UIApplication.sharedApplication.keyWindow.rootViewController;
    [mainTabBarController maximizePlayerDetailsViewWithEpisode:self.episodes[indexPath.row]];
//    PlayerDetailsView *playerDetailsView = [PlayerDetailsView new];
//    playerDetailsView.episode = self.episodes[indexPath.row];
//    [UIApplication.sharedApplication.keyWindow addSubview:playerDetailsView];
//    playerDetailsView.frame = UIApplication.sharedApplication.keyWindow.frame;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 132;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.color = UIColor.darkGrayColor;
    [activityView startAnimating];
    return activityView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.episodes.count == 0 ? 160 : 0;
}


@end
