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

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.tabBar.tintColor = UIColor.purpleColor;
    [UINavigationBar appearance].prefersLargeTitles = YES;
    
    [self setupViewControllers];
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
