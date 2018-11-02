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

@interface SearchController ()
@property (nonatomic, strong) NSMutableArray *podcasts;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation SearchController
NSString *cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];
    [self setupTableView];
    
    Podcast *podcast = [[Podcast alloc] initWithName:@"Apple" artistName:@"Steve Cook"];
    Podcast *podcast2 = [[Podcast alloc] initWithName:@"Let's Build That App" artistName:@"Brian Voong"];
    self.podcasts = [[NSMutableArray alloc] initWithObjects:podcast, podcast2, nil];
    
}

//MARK:- Setup SearchBar

- (void)setupSearchBar {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.navigationItem.searchController = self.searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [[APIService sharedInstance] fetchPodcastsWithSearchText:searchText withCompletion:^(NSMutableArray * _Nonnull podcasts) {
        self.podcasts = podcasts;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

//MARK:- Setup TableView

- (void)setupTableView {
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:cellId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.podcasts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    Podcast *podcast = self.podcasts[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@", podcast.trackName, podcast.artistName];
    cell.textLabel.numberOfLines = 0;
    cell.imageView.image = [UIImage imageNamed:@"appicon"];
    return cell;
}



@end
