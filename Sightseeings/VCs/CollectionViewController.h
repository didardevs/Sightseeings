//
//  CollectionViewController.h
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/4/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sightseeing.h"
#import "CoreDataHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
