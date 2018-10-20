//
//  Marker.m
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import "MarkerAnnotation.h"

@implementation MarkerAnnotation
- (void)setAnnotation:(id<MKAnnotation>)annotation {
    [super setAnnotation:annotation];
    
    self.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.calloutOffset = CGPointMake(5, 5);
    self.canShowCallout = YES;
    
    UILabel *customSubtitle = [UILabel new];
    customSubtitle.text = annotation.subtitle;
    customSubtitle.numberOfLines = 0;
    customSubtitle.textColor = UIColor.redColor;
    customSubtitle.font = [UIFont systemFontOfSize:13];
    self.detailCalloutAccessoryView = customSubtitle;
    
}
@end
