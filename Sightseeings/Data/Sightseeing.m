//
//  Sightseeing.m
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import "Sightseeing.h"

@implementation Sightseeing
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        _location = [dictionary valueForKey:@"location"];
        _latitude = [dictionary valueForKey:@"latitude"];
        _longitude = [dictionary valueForKey:@"longitude"];
        _title = [dictionary valueForKey:@"title"];
    }
    
    return self;
}
@end
