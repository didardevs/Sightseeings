//
//  Marker.m
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import "Marker.h"

@implementation Marker
-(instancetype)initWithArtPoint:(Sightseeing*)point  {
    self = [super init];
    if (self) {
        CLLocationCoordinate2D coordinatePoint = CLLocationCoordinate2DMake([point.latitude doubleValue],
                                                                            [point.longitude doubleValue]);
        _coordinate = coordinatePoint;
        _point = point;
    }
    return self;
}

-(instancetype)initWithSightPoint:(SightseeingCV*)point  {
    self = [super init];
    if (self) {
        CLLocationCoordinate2D coordinatePoint = CLLocationCoordinate2DMake([point.latitude doubleValue],
                                                                            [point.longitude doubleValue]);
        _coordinate = coordinatePoint;
        _pointe = point;
    }
    return self;
}

- (NSString *)title {
    return _point.title;
}

- (NSString *)subtitle {
    return _point.location;
}
@end
