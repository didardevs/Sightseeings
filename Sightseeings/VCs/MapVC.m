//
//  ViewController.m
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import "MapVC.h"
#import <MapKit/MapKit.h>
#import "DataManagement.h"
#import "Data.h"
#import "Sightseeing.h"
#import "Marker.h"
#import "MarkerAnnotation.h"
#import "DetailVC.h"
#include "CoreDataHelper.h"
#include "SightseeingCV+CoreDataProperties.h"


@interface MapVC () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) MKMapView *mapView;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) Data *dataProvider;
@property (strong, nonatomic) NSArray *artPoints;
@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first_start"];
    _coordinate = CLLocationCoordinate2DMake(21.290824, -157.85131);
    _dataProvider = [Data new];
    
    [_dataProvider getPoints:^(NSArray * _Nonnull points) {
        self->_artPoints = points;
        for (Sightseeing *point in self->_artPoints) {
            dispatch_async(dispatch_get_main_queue(),^{
                [self setMarkersFor:point];
            });
        }
        [self saveToCoreData:points];
    }];
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_coordinate, 10000, 10000);
    [_mapView setRegion:region animated:YES];
    [self startLocation];
}


-(void)startLocation {
    _locationManager = [[CLLocationManager alloc] init];
    
    if (!CLLocationManager.locationServicesEnabled) {
        return;
    }
    _locationManager.delegate = self;
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    } else {
        _mapView.showsUserLocation = YES;
    }
    
    [_locationManager startMonitoringSignificantLocationChanges];
}

-(void)setMarkersFor: (Sightseeing*)point {
    
    Marker *marker = [[Marker alloc] initWithArtPoint:point];
    
    [_mapView addAnnotation:marker];
    _mapView.delegate = self;
    [_mapView registerClass:[MarkerAnnotation class] forAnnotationViewWithReuseIdentifier:
     MKMapViewDefaultAnnotationViewReuseIdentifier];
}

#pragma mark Anatation methods

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control {
    //    [self findArtPoint:view.annotation.title];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"did select");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"New location = %@", locations);
}

-(void)saveToCoreData:(NSArray<Sightseeing*>*)points {
    
    for (Sightseeing *point in points) {
        
        SightseeingCV *pointInCoreData = (SightseeingCV*)[CoreDataHelper.sharedInstance                                                        insertNewObjectToEntity:@"SightseeingCV"];
        
        pointInCoreData.title = point.title;
        pointInCoreData.latitude = point.latitude;
        pointInCoreData.longitude = point.longitude;
        pointInCoreData.location = point.location;
    }
    
    [CoreDataHelper.sharedInstance save];
    
}

@end
