//
//  QUNewAilmentTableViewController.m
//  QQN
//
//  Created by Adam Lowther on 2/4/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>

#import "QUNewAilmentTableViewController.h"
#import "QUSeverityPickerTableViewCell.h"
#import "Severity.h"
#import "QUCoreDataManager.h"
#import "QUNewAilmentHeaderView.h"
#import "User.h"
#import "QURESTManager.h"
#import "QUDateManagementTableViewCell.h"

#define forecastAPIKey @"e1dcdf6858860bc839fc93808acd6b51"


@interface QUNewAilmentTableViewController () <QUSeverityDelegate, NSFetchedResultsControllerDelegate, UIActionSheetDelegate, CLLocationManagerDelegate>
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarItem;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic) NSNumber *currentWeatherTemp;
@property (nonatomic) NSNumber *currentWeatherHumidity;

@property (nonatomic) UIDatePicker *pickerView;

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
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
//    [self.tableView reloadData];
    
    if (self.isModal) {
        [self beingPresentedInModalPopup];
    }
    self.severitySliderValue = 0.5f;
    [self isLocationAuthorized];
}


-(void)isLocationAuthorized
{
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized){
        if ([CLLocationManager locationServicesEnabled]) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
            [self.locationManager setDelegate:self];
            [self.locationManager startUpdatingLocation];
//            self.location = [[CLLocation alloc] init];
        }
//    } else {
//        //UIAlertView to get auth
//    }
}


-(void)dealloc
{
    self.fetchedResultsController = nil;
    self.registeredTime = nil;
    self.type = nil;
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
    
    if (self.info.endTime) {
        [self.rightBarItem setEnabled:NO];
    }
}

#pragma mark - Table view data source
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *context = [[QUCoreDataManager sharedManager] context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Severity" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    if (self.predicate) {
        [fetchRequest setPredicate:self.predicate];
    }
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
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
    NSInteger numSections = [[self.fetchedResultsController sections] count];
    if (!self.info.endTime) {
        numSections+=1;
    }
    return numSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRowsInSection = 0;
    if ([[self.fetchedResultsController sections] count] == 0) {
        numRowsInSection = 2;
    } else if([[self.fetchedResultsController sections] count] == section){
        numRowsInSection = 2;
    }else {
        id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        numRowsInSection = [sectionInfo numberOfObjects];
    }

    return numRowsInSection;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0f;
    if (indexPath.section < [[self.fetchedResultsController sections] count]) {
        height = 88.0f;
    } else {
//    if (indexPath.section == [self.tableView numberOfSections]) {
        if (indexPath.row == 1) {
            height = 88.0f;
        } else {
            height = 44.0f;
        }
    }
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = nil;
    if (!(section < [[self.fetchedResultsController sections] count])) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 44.0f)];
        [headerView setBackgroundColor:[UIColor blueColor]];
//        QUNewAilmentHeaderView *newHeaderView = [[QUNewAilmentHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 44.0f)];
//        [newHeaderView setHeaderViewTextContent:@"Add More Data"];
//        headerView = newHeaderView;
    }
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierForCell = @"severityPicker";
    UITableViewCell *cell = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm a"];
    
    if (indexPath.section < [[self.fetchedResultsController sections] count]) {
        Severity *ailmentSeverity = [self.fetchedResultsController objectAtIndexPath:indexPath];
        QUSeverityPickerTableViewCell *newCell = (QUSeverityPickerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifierForCell forIndexPath:indexPath];
        [newCell.severityLabel setText:[dateFormatter stringFromDate:ailmentSeverity.time]];
        [newCell.severitySlider setValue:ailmentSeverity.currentSeverityValue animated:YES];
        [newCell.sliderValueLabel setText:[NSString stringWithFormat:@"%.2f", ailmentSeverity.currentSeverityValue*10]];
        [newCell setDelegate:self];
        [newCell.severitySlider setEnabled:NO];
        
        NSString *severityTemp = nil;
        if (ailmentSeverity.temperature != nil) {
            severityTemp = [NSString stringWithFormat:@"%.1f %@F",[ailmentSeverity.temperature doubleValue], @"\u00B0"];
        }
        [newCell.temperatureLabel setText:severityTemp];
        
        NSString *severityHumidity = nil;
        if (ailmentSeverity.humidity != nil) {
            severityHumidity = [NSString stringWithFormat:@"Humidity: %.1f%%",[ailmentSeverity.humidity doubleValue]];
        }
        [newCell.humidityLabel setText:severityHumidity];
        
        cell = newCell;
    }else {
        if (indexPath.row == 1) {
            QUSeverityPickerTableViewCell *newCell = (QUSeverityPickerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifierForCell forIndexPath:indexPath];
            [newCell.severityLabel setText:@"Severity"];
            [newCell setDelegate:self];
            
            NSString *currentTemp = [NSString stringWithFormat:@"%.1f %@F",[self.currentWeatherTemp doubleValue], @"\u00B0"];
            [newCell.temperatureLabel setText:currentTemp];
            
            NSString *currentHumidity = [NSString stringWithFormat:@"Humidity: %.1f%%",[self.currentWeatherHumidity doubleValue]];
            [newCell.humidityLabel setText:currentHumidity];
            
            cell = newCell;
        } else {
            QUDateManagementTableViewCell *newCell = (QUDateManagementTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//            if (cell == nil) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
//            }
            
            [newCell.titleLabel setText:@"Current Time"];
            [newCell setDateToManage:[NSDate date]];
            
//            [cell.textLabel setText:@"Current Time"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm a"];
            
            if (!self.registeredTime) {
                NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
//                [cell.detailTextLabel setText:currentTime];
                [newCell.detailLabel setText:currentTime];
                _registeredTime = [NSDate date];
            } else {
//                NSString *currentTime = [dateFormatter stringFromDate:self.registeredTime];
                NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
                [newCell.detailLabel setText:currentTime];
//                [cell.detailTextLabel setText:currentTime];
            }
            cell = newCell;
        }
    }
    return cell;
}

//-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    BOOL shouldHighlight = NO;
//    if (indexPath.section < [[self.fetchedResultsController sections] count]) {
//        shouldHighlight = NO;
//    } else {
////        if (indexPath.row == 0) {
////            shouldHighlight = YES;
////        }
//    }
//    return shouldHighlight;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!(indexPath.section < [[self.fetchedResultsController sections] count])) {
        if (indexPath.row == 0) {
            NSLog(@"show date picker");
            [self displayExternalDatePickerForRowAtIndexPath:indexPath];
        }
    }
}

- (void)displayExternalDatePickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // first update the date picker's date value according to our model
    QUDateManagementTableViewCell *cell = (QUDateManagementTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    
    [self.pickerView setDate:cell.dateToManage animated:YES];
    
    // the date picker might already be showing, so don't add it to our view
    if (self.pickerView.superview == nil)
    {
        CGRect startFrame = self.pickerView.frame;
        CGRect endFrame = self.pickerView.frame;
        
        // the start position is below the bottom of the visible frame
        startFrame.origin.y = self.view.frame.size.height;
        
        // the end position is slid up by the height of the view
        endFrame.origin.y = startFrame.origin.y - endFrame.size.height;
        
        self.pickerView.frame = startFrame;
        
        [self.view addSubview:self.pickerView];
        
        // animate the date picker into view
        [UIView animateWithDuration:0.50 animations: ^{ self.pickerView.frame = endFrame; }
                         completion:^(BOOL finished) {
                             // add the "Done" button to the nav bar
                         }];
    }
}

-(void)severitySliderValueChanged:(UISlider *)slider
{
    _severitySliderValue = slider.value;
}

-(void)newAilmentSaveButtonClicked
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(ailmentType.type == %@) AND (startTime == %@)", self.info.ailmentType.type, self.info.startTime];
    NSArray *savedData = [[QUCoreDataManager sharedManager] getArrayOfDataFromEntity:@"AilmentInfo" withPredicate:predicate];
    if ([savedData count] > 1) {
        NSLog(@"more than one match");
        return;
    } else if([savedData count] == 1) {
        AilmentInfo *info = [savedData firstObject];
        Severity *addSeverity = (Severity*)[NSEntityDescription insertNewObjectForEntityForName:@"Severity" inManagedObjectContext:[[QUCoreDataManager sharedManager] context]];
        [addSeverity setTime:self.registeredTime];
        [addSeverity setCurrentSeverity:[NSNumber numberWithFloat:self.severitySliderValue]];
        
        if (self.currentWeatherHumidity != nil) {
            [addSeverity setHumidity:self.currentWeatherHumidity];
        }
        if (self.currentWeatherTemp != nil) {
            [addSeverity setTemperature:self.currentWeatherTemp];
        }
        
        if (self.severitySliderValue == 0.0f) {
            [info setEndTime:[NSDate date]];
        }
        [addSeverity setInfo:info];
        NSError *error = nil;
        [[[QUCoreDataManager sharedManager] context] save:&error];
        if (error != nil) {
            NSLog(@"uh oh");
        }
        
    }else {
        NSManagedObjectContext *context = [QUCoreDataManager sharedManager].context;
//        User *user = [User findTheRegisteredUserWithName:@"Temp" inContext:context];
        AilmentInfo *info = (AilmentInfo*)[NSEntityDescription insertNewObjectForEntityForName:@"AilmentInfo" inManagedObjectContext:context];
        [info setAilmentType:self.type];
        [info setStartTime:self.registeredTime];
        
        Severity *severity = (Severity*)[NSEntityDescription insertNewObjectForEntityForName:@"Severity" inManagedObjectContext:context];
        [severity setTime:self.registeredTime];
        [severity setCurrentSeverityValue:self.severitySliderValue];
        
        if (self.currentWeatherHumidity != nil) {
            [severity setHumidity:self.currentWeatherHumidity];
        }
        if (self.currentWeatherTemp != nil) {
            [severity setTemperature:self.currentWeatherTemp];
        }
        
//        [severity setInfo:info];
        
        [info addAilmentSeverityObject:severity];
        
        [context insertObject:info];
        
        predicate = nil;
        NSError *error = nil;
        [context save:&error];
        if (error != nil) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations.lastObject;
    [self.locationManager stopUpdatingLocation];
    NSLog(@"%@", location);
    
    if (location) {
        NSDate *rightNow = [NSDate date];
        NSTimeInterval rightNowTime = [rightNow timeIntervalSince1970];
        
        NSURL *urlToRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/%f,%f,%.0f", forecastAPIKey, location.coordinate.latitude, location.coordinate.longitude, rightNowTime]];
        NSURLRequest *request = [NSURLRequest requestWithURL:urlToRequest];
        NSDictionary *weather = [[QURESTManager sharedManager] doGetWithNSURLRequest:request];
        NSNumber *tempHumidity = weather[@"data"][@"currently"][@"humidity"];
        self.currentWeatherHumidity = [NSNumber numberWithFloat:([tempHumidity floatValue]*100)];
        
        self.currentWeatherTemp = weather[@"data"][@"currently"][@"temperature"];
        [self.tableView reloadData];
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
