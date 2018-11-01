//
//  SearchControllerTableViewController.m
//  Podcasts_ObjC
//
//  Created by SEAN on 2018/10/30.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "SearchController.h"
#import "Podcast.h"
#import "Alamofire-Swift.h"

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
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@", searchText];
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

        NSNumber *count = searchResult[@"resultCount"];
        NSArray *results = searchResult[@"results"];
        [self.podcasts removeAllObjects];
        
        for (NSDictionary *result in results){
            Podcast *podcast = [[Podcast alloc] initWithName:result[@"trackName"] artistName:result[@"artistName"]];
            [self.podcasts addObject:podcast];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }] resume];
    
    NSLog(@"%@", urlString);
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
