//
//  SightseeingCV+CoreDataProperties.m
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/11/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//
//

#import "SightseeingCV+CoreDataProperties.h"

@implementation SightseeingCV (CoreDataProperties)

+ (NSFetchRequest<SightseeingCV *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SightseeingCV"];
}

@dynamic latitude;
@dynamic location;
@dynamic longitude;
@dynamic title;


@end
