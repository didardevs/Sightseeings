//
//  AppDelegate.h
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
@end

