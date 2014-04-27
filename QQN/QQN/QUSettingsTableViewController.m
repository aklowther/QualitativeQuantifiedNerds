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
#import "QUJawboneAPI.h"
#import "QUM7Manager.h"


@interface QUSettingsTableViewController () <UIWebViewDelegate>
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
    [QUJawboneAPI initAuth];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(testGetUserInfo)];
//    [self.navigationItem setRightBarButtonItem:item];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                          target:self action:@selector(testGetUserInfo)];
    [self.navigationItem setRightBarButtonItem:item];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NXOAuth2AccountStoreAccountsDidChangeNotification
                                                      object:[NXOAuth2AccountStore sharedStore]
                                                       queue:nil
                                                  usingBlock:^(NSNotification *aNotification){
                                                      // Update your UI
                                                      NSLog(@"success: %@", [aNotification userInfo]);
                                                      [self dismissViewControllerAnimated:NO completion:nil];
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NXOAuth2AccountStoreDidFailToRequestAccessNotification
                                                      object:[NXOAuth2AccountStore sharedStore]
                                                       queue:nil
                                                  usingBlock:^(NSNotification *aNotification){
                                                      NSError *error = [aNotification.userInfo
                                                              objectForKey:NXOAuth2AccountStoreErrorKey];
                                                      // Do something with the error
                                                      NSLog(@"error: %@", [error userInfo]);
                                                      [self dismissViewControllerAnimated:NO completion:nil];
                                                  }];
//    [QUM7Manager getStepsIfM7Available];
}

//-(void)testGetUserInfo
//{
//    if ([[QURESTManager sharedManager] hasTokenForSource:@"fitbit"]) {
//        NSDictionary *userInfo = [QUFitbitAPI getActivitiesForDate:[NSDate date]];
//        NSLog(@"%@",userInfo);
//        NSString *numSteps = [userInfo[@"data"][@"summary"] objectForKey:@"steps"];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Steps"
//                                                        message:[NSString stringWithFormat:@"You've taken %@ steps today", numSteps]
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
//        
//    }

//    if (!([[[NXOAuth2AccountStore sharedStore] accountsWithAccountType:@"jawboneService"] count] > 0)) {
////        [QUJawboneAPI initAuth];
//        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Auth First" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
//    }
//    
//    NXOAuth2Request *theRequest = [[NXOAuth2Request alloc] initWithResource:[NSURL URLWithString:@"https://jawbone.com/nudge/api/v.1.0/users/@me/moves"] method:@"GET" parameters:nil];
//    theRequest.account = [[[NXOAuth2AccountStore sharedStore] accountsWithAccountType:@"jawboneService"] firstObject];
//    
//    NSURLRequest *signedRequest = [theRequest signedURLRequest];
//    NSDictionary *returnData = [[QURESTManager sharedManager] doGetWithNSURLRequest:signedRequest];
//}
-(void)testGetUserInfo
{

    if ([[QURESTManager sharedManager] hasTokenForSource:@"fitbit"]) {
        NSDate *today = [NSDate date];
        NSDictionary *waterData = [QUFitbitAPI getWaterForDate:today];
        //NSString *p = @"data.summary.steps";
        //NSString *numSteps = ([waterData valueForKeyPath:p]) ? [waterData valueForKeyPath:p] : @"0";
        NSLog(@"waterData:%@", waterData);

        NSDictionary *activity = [QUFitbitAPI getActivitiesForDate:today];
        NSLog(@"activity:%@", activity);

        NSDictionary *userInfo = [QUFitbitAPI getUserInfo];
        NSLog(@"userInfo:%@", userInfo);

        NSDictionary *measurements = [QUFitbitAPI getBodyMeasurementsForDate:today];
        NSLog(@"measurements:%@", measurements);

        //TODO:Store Above responses as Core Data objects (and in the future on server)

    }
    //TODO: jawbone
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    if (indexPath.row == 0) {
        [cell.textLabel setText:@"Fitbit Auth"];
    } else if (indexPath.row == 1) {
        [cell.textLabel setText:@"Jawbone Auth"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        LoginWebViewController *loginWebViewController = [self.storyboard instantiateViewControllerWithIdentifier:
                @"loginWebViewController"];
    if (indexPath.row == 0) {
    __block NSDictionary *data = [QUFitbitAPI getConsumerAppData];
    __block NSDictionary *oauthData = [QUFitbitAPI getOAuthData];
    [self presentViewController:loginWebViewController
                       animated:YES
                     completion:^{
                         [[self oauth1Controller] loginWithConsumerData:data andStandardOauth:oauthData inWebView:
                                 loginWebViewController.webView completion:^(NSDictionary *oauthTokens, NSError *error)
                         {
                             if (!error) {                                 
                                 NSString *token = oauthTokens[@"oauth_token"];
                                 NSString *tokenSecret = oauthTokens[@"oauth_token_secret"];
                                 
                                 NSDictionary *dataToSet = [NSDictionary dictionaryWithObjects:@[token, tokenSecret,
                                         @"fitbit"] forKeys:@[@"token", @"secretToken", @"source"]];
                                 
                                 [[QURESTManager sharedManager] setTokensForSource:dataToSet];
                                 [[QURESTManager sharedManager] saveUserToken:token secret:tokenSecret];
                            
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
    } else if (indexPath.row == 1) {
        [self presentViewController:loginWebViewController animated:YES completion:^{
            [loginWebViewController.webView setDelegate:self];
            [QUJawboneAPI requestAcessUsingViewController:loginWebViewController.webView];
        }];
    }

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                                                navigationType:(UIWebViewNavigationType)navType {

    if ([[request.URL absoluteString] hasPrefix:[[NSURL URLWithString:@"qqn://jawbone"] absoluteString]]) {
        [[NXOAuth2AccountStore sharedStore] handleRedirectURL:request.URL];
        return NO;
    } else {
    }
    return YES;
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
@end
