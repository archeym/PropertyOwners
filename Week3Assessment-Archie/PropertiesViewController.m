//
//  PropertiesViewController.m
//  Week3Assessment-Archie
//
//  Created by NEXTAcademy on 4/3/17.
//  Copyright © 2017 ArchieApp. All rights reserved.
//

#import "PropertiesViewController.h"
#import "AddEditViewController.h"
#import "CoreDateManager.h"
#import "Property+CoreDataClass.h"

@interface PropertiesViewController ()<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic)NSFetchedResultsController *fetchedResultController;

@end

@implementation PropertiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = [[CoreDateManager shared]managedObjectContext];
    [self prepareTableView];
    [self setupData];
    self.navigationItem.title = @"Properties";
 
}
- (IBAction)addButtonTapped:(id)sender {
    AddEditViewController *controller = (AddEditViewController*)[self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([AddEditViewController class])];
    
    controller.currentOwner = self.currentOwner;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)prepareTableView{
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}
-(void)setupData{
    NSFetchRequest *fetchRequest = [Property fetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"toOwner.name==%@", self.currentOwner.name];
    [fetchRequest setPredicate:predicate];
        
    NSSortDescriptor *sortDecriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDecriptor]];
    
    self.fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:NULL cacheName:NULL];
    
    self.fetchedResultController.delegate = self;
    
    NSError *fetchControllerError= NULL;
    [self.fetchedResultController performFetch:&fetchControllerError];
    if (fetchControllerError) {
    }
    [self.tableView reloadData];
}
#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fetchedResultController.fetchedObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"propertiesCell" forIndexPath:indexPath];
    Property *property = [self.fetchedResultController objectAtIndexPath:indexPath];
    cell.textLabel.text = property.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Price: %@;%@%@ ", property.price, @" Location: ", property.location];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        Property *selectedProperty =[self.fetchedResultController objectAtIndexPath:indexPath];
        AddEditViewController *controller = (AddEditViewController *) [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([AddEditViewController class])];
        controller.currentProperty = selectedProperty;
        controller.navTitle = @"Edit Property";
        [self.navigationController pushViewController:controller animated:YES];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    Property *property =[self.fetchedResultController objectAtIndexPath:indexPath];
    
    [self removeProperty:property];
    
}
-(void)removeProperty:(Property*)property{
    
    [self.context deleteObject:property];
    NSError *saveErorr = NULL;
    [self.context save:&saveErorr];
    if (saveErorr) {
        return;
    }
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
@end
