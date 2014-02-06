//
//  QUAilmentsTableViewController.m
//  QQN
//
//  Created by Adam Lowther on 2/3/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUAilmentsTableViewController.h"
#import "QUCoreDataManager.h"
#import "QUExistingHeadacheTableViewCell.h"
#import "QUExistingHeadacheTableViewController.h"
#import "Ailment.h"
#import "AilmentInfo.h"
#import "Severity.h"

#import <Parse/Parse.h>
#import "SVProgressHUD.h"

@interface QUAilmentsTableViewController () <NSFetchedResultsControllerDelegate>
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end

@implementation QUAilmentsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [self fetchAilmentsFromParse];
    [super viewDidLoad];
    [self setTitle:@"Ailments"];
    
//    NSError *error;
//	if (![[self fetchedResultsController] performFetch:&error]) {
//		// Update to handle the error appropriately.
//		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//	}
//    [self.tableView reloadData];
    
//    UIBarButtonItem *addNewAilment = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewAilmentSelected)];
//
//    self.navigationItem.rightBarButtonItem = addNewAilment;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.fetchedResultsController = nil;
    // Dispose of any resources that can be recreated.
}

-(void)fetchAilmentsFromParse
{
    [SVProgressHUD show];
    Ailment *newestDownloadedAilment = [Ailment ailmentWithNewestCreatedDateInContext:[QUCoreDataManager sharedManager].context];
    NSPredicate *predicate = nil;
    if (newestDownloadedAilment.createdByParse != nil) {
        predicate = [NSPredicate predicateWithFormat:@"createdAt > %@", newestDownloadedAilment.createdByParse];
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"ailments" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [[QUCoreDataManager sharedManager] setAilments:objects];
        
        NSError *coreDataError = nil;
        if (![[self fetchedResultsController] performFetch:&coreDataError]) {
            // Update to handle the error appropriately.
            NSLog(@"Unresolved error %@, %@", coreDataError, [coreDataError userInfo]);
        }
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - Table view data source


- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *context = [[QUCoreDataManager sharedManager] context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Ailment" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"type" ascending:YES];
//    NSSortDescriptor *sort2 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:context
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"existingHeadache";
    
    QUExistingHeadacheTableViewCell *cell = (QUExistingHeadacheTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[QUExistingHeadacheTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Ailment *ailment = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
//    if ([ailment.info count] > 0)
    {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    [cell.timeLabel setText:ailment.type];
    
    if ([ailment.info count] == 0) {
        [cell.durationLabel setText:@"None reported"];
    } else {
        NSString *count = [NSString stringWithFormat:@"%lu reported", (unsigned long)[ailment.info count]];
        [cell.durationLabel setText:count];
    }
    
    CGFloat totalSeverity = 0.0f;
    CGFloat numberOfSpecificAilment = 0.0f;
    for (AilmentInfo *ailInfo in ailment.info) {
        for (Severity *sev in ailInfo.ailmentSeverity) {
            totalSeverity += sev.currentSeverityValue;
            numberOfSpecificAilment++;
        }
    }
    CGFloat sevForProgressBar = totalSeverity/numberOfSpecificAilment;
    
    [cell.headacheSeverity setProgress:sevForProgressBar];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"reviewExisting" sender:indexPath];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    QUExistingHeadacheTableViewController *vc = [segue destinationViewController];
    NSIndexPath *indexPath = (NSIndexPath*)sender;
    Ailment *ailment = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [vc setAilment:ailment];
    
    vc.predicate = [NSPredicate predicateWithFormat:@"ANY ailmentType.type == %@", ailment.type];
}


@end
