//
//  Property+CoreDataProperties.m
//  Week3Assessment-Archie
//
//  Created by NEXTAcademy on 4/3/17.
//  Copyright © 2017 ArchieApp. All rights reserved.
//

#import "Property+CoreDataProperties.h"

@implementation Property (CoreDataProperties)

+ (NSFetchRequest<Property *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Property"];
}

@dynamic location;
@dynamic name;
@dynamic price;
@dynamic toOwner;

@end
