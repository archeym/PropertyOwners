//
//  Owner+CoreDataProperties.m
//  Week3Assessment-Archie
//
//  Created by NEXTAcademy on 4/3/17.
//  Copyright © 2017 ArchieApp. All rights reserved.
//

#import "Owner+CoreDataProperties.h"

@implementation Owner (CoreDataProperties)

+ (NSFetchRequest<Owner *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
}

@dynamic name;
@dynamic toProperty;

@end
