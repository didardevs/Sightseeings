//
//  DataManagement.m
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import "DataManagement.h"

@implementation DataManagement

+(instancetype)sharedInstance {
    static DataManagement* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [DataManagement new];
    });
    return instance;
}


-(void) loadWith: (NSURL*)url completionHandler: (void(^)(NSData* data))completion {
    [[[NSURLSession sharedSession]
      dataTaskWithURL:url completionHandler:^(NSData * _Nullable data,
                                              NSURLResponse * _Nullable response,
                                              NSError * _Nullable error) {
          completion([NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil]);
      }]resume];
}
@end
