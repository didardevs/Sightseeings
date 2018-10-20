//
//  SightseeingCV+CoreDataProperties.h
//  Sightseeings
//
//  Created by Didar Naurzbayev on 10/11/18.
//  Copyright © 2018 Didar Naurzbayev. All rights reserved.
//
//

#import "SightseeingCV+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SightseeingCV (CoreDataProperties)

+ (NSFetchRequest<SightseeingCV *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, copy) NSString *title;


@end

NS_ASSUME_NONNULL_END
