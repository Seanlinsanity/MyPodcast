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
    NSURL *url = [NSURL URLWithString:feedUrl];
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
    Episode *episode = [[Episode alloc] initWithTitle:item.title];
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
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:cellId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.episodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    Episode *episode = self.episodes[indexPath.row];
    cell.textLabel.text = episode.title;
    return cell;
}


@end
