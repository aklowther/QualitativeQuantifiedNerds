//
//  QUSettingsTableViewController.m
//  QQN
//
//  Created by Adam Lowther on 2/7/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUSettingsTableViewController.h"
#import "LoginWebViewController.h"
#import "OAuth1Controller.h"
#import "QURESTManager.h"
#import "QUFitbitAPI.h"


@interface QUSettingsTableViewController ()
@property (nonatomic, strong) OAuth1Controller *oauth1Controller;
@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSString *oauthTokenSecret;

@end

@implementation QUSettingsTableViewController

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
    [self setTitle:@"Settings"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(testGetUserInfo)];
    [self.navigationItem setRightBarButtonItem:item];
    
    
//    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonSelected)];
//    [self.navigationItem setLeftBarButtonItem:cancel];
}

-(void)testGetUserInfo
{
    if ([[QURESTManager sharedManager] hasTokenForSource:@"fitbit"]) {
        NSDictionary *userInfo = [QUFitbitAPI getUserInfo];
        NSLog(@"%@",userInfo);
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    [cell.textLabel setText:@"Fitbit Auth"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginWebViewController *loginWebViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginWebViewController"];
//    [self.navigationController pushViewController:loginWebViewController animated:YES];
    __block NSDictionary *data = [QUFitbitAPI getConsumerAppData];
    __block NSDictionary *oauthData = [QUFitbitAPI getOAuthData];
    [self presentViewController:loginWebViewController
                       animated:YES
                     completion:^{
                         [[self oauth1Controller] loginWithConsumerData:data andStandardOauth:oauthData inWebView:loginWebViewController.webView completion:^(NSDictionary *oauthTokens, NSError *error) {
                             if (!error) {                                 
                                 NSString *token = oauthTokens[@"oauth_token"];
                                 NSString *tokenSecret = oauthTokens[@"oauth_token_secret"];
                                 
                                 NSDictionary *dataToSet = [NSDictionary dictionaryWithObjects:@[token, tokenSecret, @"fitbit"] forKeys:@[@"token", @"secretToken", @"source"]];
                                 
                                 [[QURESTManager sharedManager] setTokensForSource:dataToSet];
                            
                                 NSLog(@"oauthToken: %@", token);
                                 NSLog(@"oauthTokenSecret: %@", tokenSecret);
                             }
                             else
                             {
                                 NSLog(@"Error authenticating: %@", error.localizedDescription);
                             }
                             [self dismissViewControllerAnimated:YES completion: ^{
                                 self.oauth1Controller = nil;
                             }];
                         }];
                     }];

}

- (OAuth1Controller *)oauth1Controller
{
    if (_oauth1Controller == nil) {
        _oauth1Controller = [[OAuth1Controller alloc] init];
    }
    return _oauth1Controller;
}

-(void)cancelButtonSelected
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
