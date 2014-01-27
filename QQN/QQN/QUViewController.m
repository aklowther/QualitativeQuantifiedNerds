//
//  QUViewController.m
//  QQN
//
//  Created by Adam Lowther on 1/6/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUViewController.h"
#import "LoginWebViewController.h"
#import "OAuth1Controller.h"

@interface QUViewController ()
@property (nonatomic, strong) OAuth1Controller *oauth1Controller;
@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSString *oauthTokenSecret;
@end

@implementation QUViewController
- (OAuth1Controller *)oauth1Controller
{
    if (_oauth1Controller == nil) {
        _oauth1Controller = [[OAuth1Controller alloc] init];
    }
    return _oauth1Controller;
}

- (IBAction)doSomething:(id)sender {
    //code for doing what you want your button to do.
    LoginWebViewController *loginWebViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginWebViewController"];

    [self presentViewController:loginWebViewController
                       animated:YES
                     completion:^{
                         [self.oauth1Controller loginWithWebView:loginWebViewController.webView completion:^(NSDictionary *oauthTokens, NSError *error) {
                             if (!error) {
                                 // Store your tokens for authenticating your later requests, consider storing the tokens in the Keychain
                                 self.oauthToken = oauthTokens[@"oauth_token"];
                                 self.oauthTokenSecret = oauthTokens[@"oauth_token_secret"];

                                 //self.accessTokenLabel.text = self.oauthToken;
                                 //self.accessTokenSecretLabel.text = self.oauthTokenSecret;
                                 NSLog(@"oauthToken: %@", self.oauthToken);
                                 NSLog(@"oauthToken: %@", self.oauthTokenSecret);
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
    [self getProfile];
}
- (void)getProfile
{
//    NSString *path = @"1/user/-/profile.json";
//
//    NSURLRequest *preparedRequest = [OAuth1Controller preparedRequestForPath:path
//                                                                  parameters:nil
//                                                                  HTTPmethod:@"GET"
//                                                                  oauthToken:self.oauthToken
//                                                                 oauthSecret:self.oauthTokenSecret];
//
//    [NSURLConnection sendAsynchronousRequest:preparedRequest
//                                       queue:NSOperationQueue.mainQueue
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                               dispatch_async(dispatch_get_main_queue(), ^{
//                                   NSLog(@"path35 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//
//                                   if (error) NSLog(@"Error in API request: %@", error.localizedDescription);
//                               });
//                           }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
