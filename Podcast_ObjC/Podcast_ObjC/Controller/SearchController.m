//
//  SearchControllerTableViewController.m
//  Podcasts_ObjC
//
//  Created by SEAN on 2018/10/30.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "SearchController.h"
#import "Podcast.h"
#import "APIService.h"
#import "PodcastCell.h"
#import "EpisodesController.h"

@interface SearchController ()
@property (nonatomic, strong) NSMutableArray *podcasts;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation SearchController
static NSString *cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];
    [self setupTableView];
}

//MARK:- Setup SearchBar

- (void)setupSearchBar {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.navigationItem.searchController = self.searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    self.definesPresentationContext = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [[APIService sharedInstance] fetchPodcastsWithSearchText:searchText withCompletion:^(NSMutableArray * _Nonnull podcasts) {
            
            self.podcasts = podcasts;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }];
    
}

//MARK:- Setup TableView

- (void)setupTableView {
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:PodcastCell.self forCellReuseIdentifier:cellId];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.text = @"No results, please enter a search query.";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.podcasts.count > 0 ? 0 : 250;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.podcasts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PodcastCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    Podcast *podcast = self.podcasts[indexPath.row];
    cell.podcast = podcast;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EpisodesController *episodesController = [EpisodesController new];
    Podcast *podcast = self.podcasts[indexPath.row];
    episodesController.podcast = podcast;
    [self.navigationController pushViewController:episodesController animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 132;
}

@end
