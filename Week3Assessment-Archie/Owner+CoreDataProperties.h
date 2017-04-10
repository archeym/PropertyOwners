//
//  Owner+CoreDataProperties.h
//  Week3Assessment-Archie
//
//  Created by NEXTAcademy on 4/3/17.
//  Copyright © 2017 ArchieApp. All rights reserved.
//

#import "Owner+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Owner (CoreDataProperties)

+ (NSFetchRequest<Owner *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Property *> *toProperty;

@end

@interface Owner (CoreDataGeneratedAccessors)

- (void)addToPropertyObject:(Property *)value;
- (void)removeToPropertyObject:(Property *)value;
- (void)addToProperty:(NSSet<Property *> *)values;
- (void)removeToProperty:(NSSet<Property *> *)values;

@end

NS_ASSUME_NONNULL_END
