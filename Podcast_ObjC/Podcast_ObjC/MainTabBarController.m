//
//  MainTabBarController.m
//  Podcasts_ObjC
//
//  Created by SEAN on 2018/10/30.
//  Copyright © 2018 SEAN. All rights reserved.
//

#import "MainTabBarController.h"
#import "ViewController.h"
#import "SearchController.h"
#import "PlayerDetailsView.h"
#import "Episode.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController{
    NSLayoutConstraint *maximizedTopAnchorConstraint;
    NSLayoutConstraint *minimizedTopAnchorConstraint;
    PlayerDetailsView *playerDetailsView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.tabBar.tintColor = UIColor.purpleColor;
    [UINavigationBar appearance].prefersLargeTitles = YES;
    
    [self setupViewControllers];
    [self setupPlayerDetailsView];
}

- (void)setupPlayerDetailsView {
    playerDetailsView = [PlayerDetailsView new];
    playerDetailsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view insertSubview:playerDetailsView belowSubview:self.tabBar];
    
    maximizedTopAnchorConstraint = [playerDetailsView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant: self.view.frame.size.height];
    minimizedTopAnchorConstraint = [playerDetailsView.topAnchor constraintEqualToAnchor:self.tabBar.topAnchor constant: -64];
    maximizedTopAnchorConstraint.active = YES;
    
    [playerDetailsView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [playerDetailsView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [playerDetailsView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
//    NSTimer *timer;
//    timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
//        [self maximizePlayerDetailsViewWithEpisode:nil];
//    }];
}

- (void)maximizePlayerDetailsViewWithEpisode: (Episode* _Nullable)episode {
    playerDetailsView.episode = episode;
    maximizedTopAnchorConstraint.active = YES;
    maximizedTopAnchorConstraint.constant = 0;
    minimizedTopAnchorConstraint.active = NO;
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
        self.tabBar.transform = CGAffineTransformMakeTranslation(0, 100);
    } completion:nil];
}

- (void)minimizePlayerDetailsView {
    maximizedTopAnchorConstraint.active = NO;
    minimizedTopAnchorConstraint.active = YES;
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
        self.tabBar.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)setupViewControllers{
    UINavigationController *searchNavController = [self generateNavControllerWithRootViewController:[SearchController new] title:@"Search" image:[UIImage imageNamed:@"search"]];
    UINavigationController *favoritesNavController = [self generateNavControllerWithRootViewController:[ViewController new] title:@"Favorites" image:[UIImage imageNamed:@"favorites"]];
    
    UINavigationController *downloadsNavController = [self generateNavControllerWithRootViewController:[ViewController new] title:@"Downloads" image:[UIImage imageNamed:@"downloads"]];
    
    
    self.viewControllers = [[NSMutableArray alloc] initWithObjects:searchNavController, favoritesNavController, downloadsNavController, nil];
}

- (UINavigationController*)generateNavControllerWithRootViewController: (UIViewController*)rootViewController title: (NSString*)title image: (UIImage*)image{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    rootViewController.navigationItem.title = title;
    navController.tabBarItem.title = title;
    navController.tabBarItem.image = image;
    return navController;
}


@end
