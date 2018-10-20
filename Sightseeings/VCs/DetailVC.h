//
//  DetailVC.h
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/3/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sightseeing.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailVC : UIViewController
-(instancetype)initWithArtPoint:(Sightseeing*)point;
@end

NS_ASSUME_NONNULL_END
