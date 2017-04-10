//
//  AddEditViewController.h
//  Week3Assessment-Archie
//
//  Created by NEXTAcademy on 4/3/17.
//  Copyright © 2017 ArchieApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Owner+CoreDataClass.h"
#import "Property+CoreDataClass.h"

@interface AddEditViewController : UIViewController
@property(strong, nonatomic) Owner *currentOwner;
@property(strong, nonatomic) Property *currentProperty;
@property(strong,nonatomic) NSString *navTitle;
@end
