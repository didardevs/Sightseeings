//
//  TabBarController.m
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import "TabBarController.h"
#import "MapVC.h"
#import "CollectionViewController.h"
#import "FavViewController.h"




@implementation TabBarController

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.viewControllers = [self createViewControllers];
        self.tabBar.tintColor = [UIColor blackColor];
    }
    return self;
}

- (NSArray<UIViewController*> *)createViewControllers {
    NSMutableArray<UIViewController*> *controllers = [NSMutableArray new];
    
    MapVC *mainViewController = [[MapVC alloc] init];
    mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Maps" image:[UIImage imageNamed:@"map-pin"] selectedImage:[UIImage imageNamed:@"map-pin"]];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [controllers addObject:mainNavigationController];
    
    CollectionViewController *collectViewController = [[CollectionViewController alloc] init];
    collectViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Sights" image:[UIImage imageNamed:@"text-pic-left"] selectedImage:[UIImage imageNamed:@"text-pic-left"]];
    UINavigationController *collectNavigationController = [[UINavigationController alloc] initWithRootViewController:collectViewController];
    [controllers addObject:collectNavigationController];
    
    FavViewController *favViewController = [[FavViewController alloc] init];
    favViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Favs" image:[UIImage imageNamed:@"map-pin"] selectedImage:[UIImage imageNamed:@"map-pin"]];
    UINavigationController *favNavigationController = [[UINavigationController alloc] initWithRootViewController:favViewController];
    [controllers addObject:favNavigationController];
    
    return controllers;
}

@end
