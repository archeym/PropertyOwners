//
//  OwnersViewController.m
//  Week3Assessment-Archie
//
//  Created by NEXTAcademy on 4/3/17.
//  Copyright © 2017 ArchieApp. All rights reserved.
//
#import "OwnersViewController.h"
#import "CoreDateManager.h"
#import "Owner+CoreDataClass.h"
#import "PropertiesViewController.h"
#import "Property+CoreDataClass.h"

@interface OwnersViewController ()<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSArray *ownersList;
@property(nonatomic, strong) NSManagedObjectContext *context;
@property (strong, nonatomic)NSFetchedResultsController *fetchedResultController;
@property(strong, nonatomic)NSFetchRequest *fetchRequest;

@end

@implementation OwnersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.context = [[CoreDateManager shared]managedObjectContext];
    [self setOwners];
    [self fetchData];
    [self prepareTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

-(void)prepareTableView{
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
}
-(void)setOwners{

    self.ownersList = [[NSArray alloc]init];
    self.ownersList = [NSArray arrayWithObjects:@"Archie",@"Mak",@"Nick",@"Sean",@"Marty",@"Ed",@"Todd",@"Tom",@"Sam", nil];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if(![userDefault boolForKey:@"list"]){
        for (NSString *name in self.ownersList) {
            Owner *newOwner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:self.context];
            newOwner.name = name;
        }
        NSError *saveError = NULL;
        [self.context save:&saveError];
        
        if(saveError){
            //show error
            return;
        }
        [userDefault setBool:YES forKey:@"list"];
    }
}
    
-(void)fetchData{
    self.fetchRequest = [Owner fetchRequest];
    NSSortDescriptor *sortDecriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [self.fetchRequest setSortDescriptors:@[sortDecriptor]];
    
    self.fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest managedObjectContext:self.context sectionNameKeyPath:NULL cacheName:NULL];
    
    self.fetchedResultController.delegate = self;
    
    NSError *fetchControllerError= NULL;
    [self.fetchedResultController performFetch:&fetchControllerError];
    if (fetchControllerError) {
        
    }
    [self.tableView reloadData];
    
}

#pragma mark - UITableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   Owner *owner = [self.fetchedResultController objectAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ownersCell" forIndexPath:indexPath];
    
//    [self.fetchRequest setEntity:[NSEntityDescription entityForName:@"Owner" inManagedObjectContext:self.context]];
    
    cell.textLabel.text = owner.name;
    
    NSMutableString *allPropertiesName = [@"" mutableCopy];
    for (Property *property in owner.toProperty){
        [allPropertiesName appendFormat:@"%@, ", property.name];
    
    }
    cell.detailTextLabel.text = allPropertiesName;
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.fetchedResultController.fetchedObjects.count;
}

#pragma mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Owner *selectedOwner= [self.fetchedResultController objectAtIndexPath:indexPath];
    PropertiesViewController *controller = (PropertiesViewController*)[self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PropertiesViewController class])];
    controller.currentOwner = selectedOwner;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
#pragma mark - UITableViewDelegate

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    [self.tableView beginUpdates];
    switch (type) {
        case NSFetchedResultsChangeInsert:
        {
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        case NSFetchedResultsChangeDelete:
        {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
            break;
        case NSFetchedResultsChangeMove:
        {
            [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
        }
            break;
        case NSFetchedResultsChangeUpdate:
        {
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
            break;
    }
    [self.tableView endUpdates];
}
- (IBAction)colorButtonTapped:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose default Color!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Strawberry" style:UIAlertActionStyleDefault handler:^(UIAlertAction *alert) {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
        
    }];
    [alert addAction:dismissAction];
    UIAlertAction *dismissAction2 = [UIAlertAction actionWithTitle:@"Banana" style:UIAlertActionStyleDefault handler:^(UIAlertAction *alert) {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"banana"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
    
    }];
    [alert addAction:dismissAction2];
    
    UIAlertAction *dismissAction3 = [UIAlertAction actionWithTitle:@"Orange" style:UIAlertActionStyleDefault handler:^(UIAlertAction *alert) {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"orange"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
        
    }];
    
    [alert addAction:dismissAction3];
    
    UIAlertAction *dismissAction4 = [UIAlertAction actionWithTitle:@"Reset To White" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *alert) {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"white"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
    }];
//    UIAlertAction *dismissAction4 = [UIAlertAction actionWithTitle:@"Cancel!" style:UIAlertActionStyleDestructive handler:NULL];
    [alert addAction:dismissAction4];
    [self presentViewController:alert animated:YES completion:NULL];
}

@end
