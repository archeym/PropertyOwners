//
//  AddEditViewController.m
//  Week3Assessment-Archie
//
//  Created by NEXTAcademy on 4/3/17.
//  Copyright © 2017 ArchieApp. All rights reserved.
//

#import "AddEditViewController.h"
#import "CoreDateManager.h"
#import "Property+CoreDataClass.h"

@interface AddEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property(strong, nonatomic)NSManagedObjectContext *context;

@end

@implementation AddEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = [[CoreDateManager shared]managedObjectContext];
    NSFetchRequest *fecthRequest = [Property fetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"toOwner.name == %@", self.currentOwner.name];
    [fecthRequest setPredicate:predicate];
    
    self.nameTextField.text = self.currentProperty.name;
    self.priceTextField.text = self.currentProperty.price;
    self.locationTextField.text = self.currentProperty.location;
    
    self.navigationItem.title = self.navTitle;   
}
- (IBAction)doneButtonTapped:(id)sender {

    Property *newProperty =(Property *)[NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:self.context];
    if(!self.currentProperty){
    
    newProperty.name = self.nameTextField.text;
    newProperty.price = self.priceTextField.text;
    newProperty.location = self.locationTextField.text;
    newProperty.toOwner = self.currentOwner;//establish relationship
    
    }else{
        self.currentProperty.name = self.nameTextField.text;
        self.currentProperty.price = self.priceTextField.text;
        self.currentProperty.location = self.locationTextField.text;
    }
    NSError *saveError = NULL;
    [self.context save:&saveError];
    if(saveError){
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
