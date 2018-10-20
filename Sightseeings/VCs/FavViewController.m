//
//  FavViewController.m
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/11/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import "FavViewController.h"
#import "MapVC.h"
#import <MapKit/MapKit.h>
#import "DataManagement.h"
#import "Data.h"
#import "Sightseeing.h"
#import "Marker.h"
#import "MarkerAnnotation.h"

#include "CoreDataHelper.h"
#include "SightseeingCV+CoreDataProperties.h"





@interface FavViewController ()<MKMapViewDelegate>

@property (strong, nonatomic) NSMutableArray *sightseeings;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MKMapView *mapView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *dateTextField;

@end

@implementation FavViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sightseeings = [NSMutableArray new];
    [self addCollectionView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self getFavoriteArrayObjects];
}

-(void)addCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 10.0;
    layout.itemSize = CGSizeMake(100.0, 100.0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = UIColor.whiteColor;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:_collectionView];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _sightseeings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Sightseeing *point = _sightseeings[indexPath.row];
    
    _mapView = [[MKMapView alloc] initWithFrame:cell.contentView.frame];
    _mapView.scrollEnabled = NO;
    _mapView.delegate = self;
    
    [cell.contentView addSubview:_mapView];
    
    [self setMapViewRegionWithLatitude:[point.latitude doubleValue]
                              longiude:[point.longitude doubleValue]];
    [self setMarkersFor:point];
    
    return cell;
}

-(void)setMapViewRegionWithLatitude: (double)latitude longiude: (double)longitude  {
    CLLocationCoordinate2D cordinate = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(cordinate, 200, 200);
    [_mapView setRegion:region animated:NO];
}

-(void)setMarkersFor: (Sightseeing*)point {
    Marker *marker = [[Marker alloc] initWithArtPoint:point];
    [_mapView addAnnotation:marker];
    [_mapView registerClass:[MarkerAnnotation class] forAnnotationViewWithReuseIdentifier:
     MKMapViewDefaultAnnotationViewReuseIdentifier];
}

#pragma mark подготовка массива

-(void)getFavoriteArrayObjects{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *arrayFavorits = [defaults objectForKey:@"favs"];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SightseeingCV"];
    NSError *error = nil;
    NSArray *results = [[CoreDataHelper.sharedInstance context] executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (int i = 0; i < 100; i++) {
        Sightseeing *point = [results objectAtIndex:i];
        if ([arrayFavorits containsObject:point.title]) {
            //NSLog(@"%ul", i);
            [self.sightseeings addObject:point];
        }
    }
    
    NSLog(@"%lul", (unsigned long)[_sightseeings count]);
    [_collectionView reloadData];
}



@end
