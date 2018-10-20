//
//  Data.m
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import "Data.h"
#import "DataManagement.h"
#import "Sightseeing.h"


@interface Data ()
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSURLSession *urlSession;

@end

@implementation Data

- (void)getPoints:(void (^)(NSArray* points))completion {
    [[DataManagement sharedInstance] loadWith:[self getUrl] completionHandler:^(NSData * _Nonnull data) {
        NSDictionary* response = data;
        NSMutableArray* array = [NSMutableArray new];
        if (response) {
            for (NSDictionary* dictionary in response){
                Sightseeing* artPoint = [[Sightseeing alloc] initWithDictionary:dictionary];
                [array addObject:artPoint];
            }
        }
        completion(array);
        NSLog(@"%@", array);
        
        
    }];
}

-(NSURL*)getUrl {
    NSString* urlString = [NSString
                           stringWithFormat:@"https://data.honolulu.gov/resource/csir-pcj2.json?$$app_token=UG3jo2sTS2XyNxwvf7vT92jY1"];
    return [NSURL URLWithString:urlString];
}

@end
