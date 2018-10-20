//
//  ContentViewController.h
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/13/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentViewController : UIViewController

@property (nonatomic, strong) NSString *contentText;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) int index;


@end

NS_ASSUME_NONNULL_END
