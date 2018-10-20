//
//  DetailVC.m
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import "DetailVC.h"
#import <MapKit/MapKit.h>

@interface DetailVC ()

@property (strong, nonatomic) NSString* latitude;
@property (strong, nonatomic) NSString* longitude;
@property (strong, nonatomic) NSString* location;
@property (strong, nonatomic) NSString* myTitle;
@end

@implementation DetailVC


-(instancetype)initWithArtPoint:(Sightseeing*)point {
    self = [super init];
    if (self) {
        _latitude = point.latitude;
        _longitude = point.longitude;
        _location = point.location;
        _myTitle = point.title;
        self.view.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self presentCLGeocoder];
}

-(void)presentCLGeocoder {
    CLLocation* pointLocation = [[CLLocation alloc] initWithLatitude:[_latitude doubleValue] longitude:[_longitude doubleValue]];
    
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:pointLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        [self setSubview:[placemarks objectAtIndex:0].locality];
    }];
}

-(void)setSubview:(NSString*)adress {
    
    UILabel *titleLable = [[UILabel alloc]
                           initWithFrame:CGRectMake(16,
                                                    100,
                                                    [UIScreen mainScreen].bounds.size.width,
                                                    30)];
    titleLable.backgroundColor = UIColor.cyanColor;
    titleLable.text = adress;
    [self.view addSubview:titleLable];
    
}
@end
