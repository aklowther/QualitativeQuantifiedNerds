//
//  QUExistingHeadacheTableViewController.m
//  QQN
//
//  Created by Adam Lowther on 2/3/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUExistingHeadacheTableViewController.h"
#import "QUExistingHeadacheTableViewCell.h"

@interface QUExistingHeadacheTableViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *addNewHeadache = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewHeadacheSelected)];
    self.navigationItem.rightBarButtonItem = addNewHeadache;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"existingHeadache";
    
    QUExistingHeadacheTableViewCell *cell = (QUExistingHeadacheTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
//    [cell.timeLabel setText:@"blah"];
    
//I want this to be in the cell init instead, haven't had time to play with it
    [cell.headacheSeverity setGradientColors:@[//HexToUIColor(0x00FF00),
                                               //HexToUIColor(0x12FF00),
                                               //HexToUIColor(0x24FF00),
                                               HexToUIColor(0x35FF00),
                                               HexToUIColor(0x47FF00),
                                               HexToUIColor(0x58FF00),
                                               HexToUIColor(0x6AFF00),
                                               HexToUIColor(0x7CFF00),
                                               HexToUIColor(0x8DFF00),
                                               HexToUIColor(0x9FFF00),
                                               HexToUIColor(0xB0FF00),
                                               HexToUIColor(0xC2FF00),
                                               HexToUIColor(0xD4FF00),
                                               HexToUIColor(0xE5FF00),
                                               HexToUIColor(0xF7FF00),
                                               HexToUIColor(0xFFF600),
                                               HexToUIColor(0xFFE400),
                                               HexToUIColor(0xFFD300),
                                               HexToUIColor(0xFFC100),
                                               HexToUIColor(0xFFAF00),
                                               HexToUIColor(0xFF9E00),
                                               HexToUIColor(0xFF8C00),
                                               HexToUIColor(0xFF7B00),
                                               HexToUIColor(0xFF6900),
                                               HexToUIColor(0xFF5700),
                                               HexToUIColor(0xFF4600),
                                               HexToUIColor(0xFF3400),
                                               HexToUIColor(0xFF1100),
                                               HexToUIColor(0xFF2300),
                                               HexToUIColor(0xFF0000)]];


    [cell.headacheSeverity setProgress:1.0f];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


-(void)addNewHeadacheSelected
{
    
}

@end
