//
//  Sightseeing.h
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sightseeing : NSObject

@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSString* latitude;
@property (nonatomic, strong) NSString* longitude;
@property (nonatomic, strong) NSString* title;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
