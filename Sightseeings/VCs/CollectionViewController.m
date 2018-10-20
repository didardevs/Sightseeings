//
//  CollectionViewController.m
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/4/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import "CollectionViewController.h"
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

@interface CollectionViewController () <UISearchResultsUpdating, UIGestureRecognizerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) NSArray *sightseeings;
@property (strong, nonatomic) NSArray *searchArray;
@property (strong, nonatomic) UIImageView *mapImage;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSMutableDictionary *snapshotsMaps;
@property (strong, nonatomic) NSMutableArray *favoritsTitle;
@property BOOL selectFlag;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _snapshotsMaps = [NSMutableDictionary new];
    _favoritsTitle = [NSMutableArray new];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchArray = [NSArray new];
    _searchController.definesPresentationContext = YES;
    self.navigationItem.searchController = _searchController;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.title = NSLocalizedString(@"search", @"search");
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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SightseeingCV"];
    NSError *error = nil;
    NSArray *results = [[CoreDataHelper.sharedInstance context] executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    _sightseeings = results;
    [self addLongPressGestureToCollectionView];
    _selectFlag = NO;
}





-(void)addButtonAfterSelect {
    
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc]
                                      initWithTitle: NSLocalizedString(@"save", @"save")
                                      style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(tapSaveButton)];
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc]
                                        initWithTitle: NSLocalizedString(@"cancel", @"cancel")
                                        style:UIBarButtonItemStyleDone
                                        target:self
                                        action:@selector(tapCancelButton)];
    
    self.navigationItem.rightBarButtonItem = saveBarButton;
    self.navigationItem.leftBarButtonItem = cancelBarButton;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_searchController.isActive && [_searchArray count] > 0) {
        return [_searchArray count];
    }
    return _sightseeings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = UIColor.whiteColor;
    
    Sightseeing *point = _sightseeings[indexPath.row];
    
    UIView *view = [_snapshotsMaps objectForKey:point.title];
    NSLog(@"view: %@", view);
    
    if (view) {
        [cell.contentView addSubview:view];
        return cell;
    }
    
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

#pragma mark <UICollectionViewDelegate>

-(void)addLongPressGestureToCollectionView {
    // attach long press gesture to collectionView
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]
                                                      initWithTarget:self action:@selector(handleLongPress:)];
    longPressGesture.delegate = self;
    longPressGesture.delaysTouchesBegan = YES;
    [self.collectionView addGestureRecognizer:longPressGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleTap:)];
    tapGesture.delegate = self;
    tapGesture.delaysTouchesBegan = YES;
    [self.collectionView addGestureRecognizer:tapGesture];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint point = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    if (indexPath == nil){
        NSLog(@"");
    } else {
        // get the cell at indexPath (the one you long pressed)
        UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];

        [self selectCell:cell];
        [self addButtonAfterSelect];
        Sightseeing *artPoint = _sightseeings[indexPath.row];
        [_favoritsTitle addObject:artPoint.title];
        NSLog(@" %ld", (long)indexPath.row);
        [self.view snapshotViewAfterScreenUpdates:YES];
        _selectFlag = YES;
    }
}

-(void)handleTap:(UITapGestureRecognizer*)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded || _selectFlag == NO) {
        return;
    }
    
    CGPoint point = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    if (indexPath == nil){
        NSLog(@"");
    } else {
        Sightseeing *artPoint = _sightseeings[indexPath.row];
        UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        if (cell.layer.borderWidth == 5) {
            [self deSelectCell:cell];
            [_favoritsTitle removeObject:artPoint.title];
            NSLog(@"%lu", [_favoritsTitle count]);
        } else {
            [self selectCell:cell];
            
            [_favoritsTitle addObject:artPoint.title];
            NSLog(@"%lu", [_favoritsTitle count]);
            
        }
    }
}

-(void)selectCell:(UICollectionViewCell*)cell {
    cell.layer.borderWidth = 5;
    cell.layer.borderColor = UIColor.greenColor.CGColor;
    [self.view snapshotViewAfterScreenUpdates:YES];
}

-(void)deSelectCell:(UICollectionViewCell*)cell {
    cell.layer.borderWidth = 0;
    cell.layer.borderColor = UIColor.blueColor.CGColor;
    [self.view snapshotViewAfterScreenUpdates:YES];
}

#pragma mark <MapViewDelegate>

// когда карта загрузилась полностью
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    
    // ждем немного
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        

        
    });
    
}

#pragma mark searchResulrUpdate

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title CONTAINS[cd]%@",
                                  searchController.searchBar.text];
        _searchArray = [_sightseeings filteredArrayUsingPredicate:predicate];
        [_collectionView reloadData];
    }
}

#pragma mark Save/Cancel buttons methods

-(void)tapSaveButton {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_favoritsTitle forKey:@"favs"];
    
    UIAlertController *alert=   [UIAlertController
                                 alertControllerWithTitle:NSLocalizedString(@"saved", @"saved")
                                 message:NSLocalizedString(@"addedFav", @"addedFav")
                                 preferredStyle:UIAlertControllerStyleAlert];
    

[self presentViewController:alert animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alert dismissViewControllerAnimated:YES completion:^{
            
            //Dismissed
        }];
        
    });
    
    [defaults synchronize];
    [self cleanMark];
}

-(void)tapCancelButton {
    
    [_favoritsTitle removeAllObjects];
    [self cleanMark];
    
}

-(void)cleanMark {
    for (int i = 0; i < 50; i++) {
        NSIndexPath* cellPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:cellPath];
        [self deSelectCell:cell];
    }
}


@end
