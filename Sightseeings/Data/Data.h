//
//  Data.h
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Data : NSObject
- (void)getPoints:(void (^)(NSArray* points))completion;
@end

NS_ASSUME_NONNULL_END
