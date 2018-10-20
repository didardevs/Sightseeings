//
//  DataManagement.h
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManagement : NSObject
+(instancetype) sharedInstance;
-(void) loadWith: (NSURL*)url completionHandler: (void(^)(NSData* data))completion;
@end

NS_ASSUME_NONNULL_END
