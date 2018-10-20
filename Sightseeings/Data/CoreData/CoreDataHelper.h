//
//  CoreDataHelper.h
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/11/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sightseeing.h"
#import "SightseeingCV+CoreDataClass.h"
#import "DataManagement.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataHelper : NSObject
+ (instancetype)sharedInstance;
-(NSManagedObjectContext*)context;
-(NSManagedObject*)insertNewObjectToEntity:(NSString*)name;
-(void)save;

@end

NS_ASSUME_NONNULL_END
