//
//  QUExistingHeadacheTableViewController.m
//  QQN
//
//  Created by Adam Lowther on 2/3/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUExistingHeadacheTableViewController.h"
#import "QUExistingHeadacheTableViewCell.h"
#import "QUCoreDataManager.h"
#import "QUNewAilmentTableViewController.h"

@interface QUExistingHeadacheTableViewController () <NSFetchedResultsControllerDelegate>
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end

@implementation QUExistingHeadacheTableViewController

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
    [super viewDidLoad];
    [self setTitle:self.ailment.type];

    UIBarButtonItem *addNew = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewHeadacheSelected:)];
    self.navigationItem.rightBarButtonItem = addNew;
    
//    NSError *error;
//	if (![[self fetchedResultsController] performFetch:&error]) {
//		// Update to handle the error appropriately.
//		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//	}
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *context = [[QUCoreDataManager sharedManager] context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AilmentInfo" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    if (self.predicate) {
        [fetchRequest setPredicate:self.predicate];
    }
    
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:NO];
    //    NSSortDescriptor *sort2 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                  managedObjectContext:context
                                                                                                    sectionNameKeyPath:nil
                                                                                                             cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"existingHeadache";
    
    QUExistingHeadacheTableViewCell *cell = (QUExistingHeadacheTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    AilmentInfo *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy h:mm a"];
    NSString *startTime = [dateFormatter stringFromDate:info.startTime];
    
    [cell.timeLabel setText:startTime];
    
    NSString *duration = @"";
    if (info.endTime) {
        NSTimeInterval distanceBetweenDates = [info.endTime timeIntervalSinceDate:info.startTime];
        float hours = distanceBetweenDates/3600.0f;
        //float minutes = hours/60.0f;
        //float seconds = round(distanceBetweenDates - minutes * 60.0f);
//        double secondsInAnHour = 3600;
//        CGFloat hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
        duration = [NSString stringWithFormat:@"%.2f hours", hours];
        
//        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//        
//        NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
//        
//        NSDateComponents *components = [gregorian components:unitFlags
//                                                    fromDate:info.startTime
//                                                      toDate:info.endTime options:0];
        
//        duration = [self prettyPrintTimeDurationWithComponents:components];
    }

    [cell.durationLabel setText:duration];
    
    CGFloat totalSeverity = 0.0f;
    CGFloat numberOfSpecificAilment = 0.0f;
    
    for (Severity *sev in info.ailmentSeverity)
    {
        totalSeverity += sev.currentSeverityValue;
        numberOfSpecificAilment++;
    }
    CGFloat sevForProgressBar = totalSeverity/numberOfSpecificAilment;
    [cell.headacheSeverity setProgress:sevForProgressBar];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"addNewAilment" sender:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [[[QUCoreDataManager sharedManager] context] deleteObject:object];
        
        NSError *error;
        [[[QUCoreDataManager sharedManager] context] save:&error];
        if (error != nil) {
            NSLog(@"Error deleting context: Error = %@, details = %@",error,error.userInfo);
        }
    }
}

#pragma mark FetchedResultsController Delegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
//        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
//                    atIndexPath:indexPath];
//            break;
            
//        case NSFetchedResultsChangeMove:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
//                             withRowAnimation:UITableViewRowAnimationFade];
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
//                             withRowAnimation:UITableViewRowAnimationFade];
//            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"addNewAilment"]) {
        UINavigationController *navController = [segue destinationViewController];
        NSArray *navViews = [navController viewControllers];
        QUNewAilmentTableViewController *vc = [navViews firstObject];
        [vc setIsModal:YES];
        [vc setType:self.ailment];
        [vc setTitle:[NSString stringWithFormat:@"%@", self.ailment.type]];
        [vc setPredicate:[NSPredicate predicateWithFormat:@"info.ailmentType.type == %@ AND info.startTime == %@", self.ailment.type, [NSDate date]]];
        
        
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY ailmentType.type == %@ AND startTime == %@", self.type.type, self.info.startTime];
        
        if ([sender isKindOfClass:[NSIndexPath class]]) {
            NSIndexPath *indexPath = (NSIndexPath*)sender;
            AilmentInfo *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
            [vc setInfo:info];
            [vc setPredicate:[NSPredicate predicateWithFormat:@"info.ailmentType.type == %@ AND info.startTime == %@", self.ailment.type, info.startTime]];
//            [vc setRegisteredTime:info.startTime];
        }
        
//    } else if ([segue.identifier isEqualToString:@"editExistingAilment"]) {
//
//        QUNewAilmentTableViewController *vc = [segue destinationViewController];
//        [vc setIsModal:NO];
//        [vc setType:self.ailment];
//        [vc setTitle:[NSString stringWithFormat:@"Edit %@", self.title]];
    }
}

-(NSString*)prettyPrintTimeDurationWithComponents:(NSDateComponents*)components
{
    NSMutableString *formattedTime = [NSMutableString string];
    NSInteger months = [components month];
    NSInteger days = [components day];
    NSInteger hours = [components hour];
    NSInteger minutes = [components minute];
    NSInteger seconds = [components second];
    
    if (months > 0) {
        [formattedTime appendFormat:@"%d months ", months];
    }
    if (days > 0) {
        [formattedTime appendFormat:@"%d days ", days];
    }
    if (hours > 0) {
        [formattedTime appendFormat:@"%d hours ", hours];
    }
    if (minutes > 0) {
        [formattedTime appendFormat:@"%d minutes ", minutes];
    }
    if (seconds > 0) {
        [formattedTime appendFormat:@"%d seconds ", seconds];
    }
    return formattedTime;
}


-(void)addNewHeadacheSelected:(id)sender
{
    [self performSegueWithIdentifier:@"addNewAilment" sender:sender];
    
}

@end
