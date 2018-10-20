//
//  FavViewController.h
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/11/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface FavViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
