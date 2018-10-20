//
//  Marker.h
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Sightseeing.h"
#import "SightseeingCV+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Marker : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) Sightseeing* point;
@property(nonatomic, strong) SightseeingCV* pointe;
-(instancetype)initWithArtPoint:(Sightseeing*)point;
-(instancetype)initWithSightPoint:(SightseeingCV*)point;


@end

NS_ASSUME_NONNULL_END
