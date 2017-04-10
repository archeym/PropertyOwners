//
//  Property+CoreDataProperties.h
//  Week3Assessment-Archie
//
//  Created by NEXTAcademy on 4/3/17.
//  Copyright © 2017 ArchieApp. All rights reserved.
//

#import "Property+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Property (CoreDataProperties)

+ (NSFetchRequest<Property *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *price;
@property (nullable, nonatomic, retain) Owner *toOwner;

@end

NS_ASSUME_NONNULL_END
