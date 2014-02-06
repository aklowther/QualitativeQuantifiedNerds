//
//  QUNewAilmentTableViewController.m
//  QQN
//
//  Created by Adam Lowther on 2/4/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUNewAilmentTableViewController.h"
#import "QUSeverityPickerTableViewCell.h"
#import "Severity.h"
#import "QUCoreDataManager.h"


@interface QUNewAilmentTableViewController () <QUSeverityDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarItem;
@end

@implementation QUNewAilmentTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.isModal) {
        [self beingPresentedInModalPopup];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)beingPresentedInModalPopup
{    
    [self.leftBarItem setTitle:@"Cancel"];
    [self.leftBarItem setTarget:self];
    [self.leftBarItem setAction:@selector(dismissModalViewControllerAnimated:)];
    
    [self.rightBarItem setTitle:@"Save"];
    [self.rightBarItem setTarget:self];
    [self.rightBarItem setAction:@selector(newAilmentSaveButtonClicked)];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0f;
    if (indexPath.row == 1) {
        height = 88.0f;
    } else {
        height = 44.0f;
    }
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierForCell = @"severityPicker";
    UITableViewCell *cell = nil;
    if (indexPath.row == 1) {
        QUSeverityPickerTableViewCell *newCell = (QUSeverityPickerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifierForCell forIndexPath:indexPath];
        [newCell.severityLabel setText:@"Severity"];
        [newCell setDelegate:self];
        cell = newCell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        }
        [cell.textLabel setText:@"Current Time"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm a"];
        
        if (!self.registeredTime) {
            NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
            [cell.detailTextLabel setText:currentTime];
            _registeredTime = [NSDate date];
        } else {
            NSString *currentTime = [dateFormatter stringFromDate:self.registeredTime];
            [cell.detailTextLabel setText:currentTime];
        }

    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)severitySliderValueChanged:(UISlider *)slider
{
    _severitySliderValue = slider.value;
}

-(void)newAilmentSaveButtonClicked
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY ailmentType.type == %@ AND startTime == %@", self.type, self.registeredTime];
    NSArray *savedData = [[QUCoreDataManager sharedManager] getArrayOfDataFromEntity:@"AilmentInfo" withPredicate:predicate];
    if ([savedData count] > 1) {
        NSLog(@"more than one match");
    } else {
        AilmentInfo *info = (AilmentInfo*)[NSEntityDescription insertNewObjectForEntityForName:@"AilmentInfo" inManagedObjectContext:[QUCoreDataManager sharedManager].context];
        [info setAilmentType:self.type];
        [info setStartTime:self.registeredTime];
        
        Severity *severity = (Severity*)[NSEntityDescription insertNewObjectForEntityForName:@"Severity" inManagedObjectContext:[[QUCoreDataManager sharedManager] context]];
        [severity setTime:self.registeredTime];
        [severity setCurrentSeverity:[NSNumber numberWithFloat:self.severitySliderValue]];
        
        [info addAilmentSeverityObject:severity];
        
        [[[QUCoreDataManager sharedManager] context] insertObject:info];
        
        NSError *error = nil;
        [[[QUCoreDataManager sharedManager] context] save:&error];
        if (error) {
            NSLog(@"uh oh");
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
