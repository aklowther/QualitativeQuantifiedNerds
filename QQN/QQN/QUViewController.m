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
@property (weak, nonatomic) IBOutlet UILabel *tokenLbl;
@property (weak, nonatomic) IBOutlet UILabel *verificationLbl;
@property (weak, nonatomic) IBOutlet UITextField *tokenTxtBox;
@property (weak, nonatomic) IBOutlet UITextField *verificationTxtBox;
@property (weak, nonatomic) IBOutlet UIButton *getProfileBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
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
- (IBAction)handleProfileBtnPress:(id)sender {
    [self getProfile];
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
}
- (void)getProfile
{
    self.oauthToken = @"cb1f98a9f92d4bde2b4228001c8c3a47";
    self.oauthTokenSecret = @"cf8748daefd44cbb905799f9447d96cd";


    NSString *path = @"1/user/-/profile.json";

    NSURLRequest *preparedRequest = [OAuth1Controller preparedRequestForPath:path
                                                                  parameters:nil
                                                                  HTTPmethod:@"GET"
                                                                  oauthToken:self.oauthToken
                                                                 oauthSecret:self.oauthTokenSecret];

    [NSURLConnection sendAsynchronousRequest:preparedRequest
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSLog(@"path35 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

                                   if (error) NSLog(@"Error in API request: %@", error.localizedDescription);
                               });
                           }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userStateChanged:) name:@"usrStateChanged" object:nil];

}
-(void)userStateChanged:(NSNotification *)aNotification{
    NSDictionary *obj = (NSDictionary *)aNotification.object;
    NSLog(@"obj: %@", obj);

    [_tokenLbl setHidden:NO];
    [_verificationLbl setHidden:NO];
    [_tokenTxtBox setHidden:NO];
    [_verificationTxtBox setHidden:NO];
    [_verificationTxtBox setEnabled:NO];
    [_tokenTxtBox setEnabled:NO];
    [_getProfileBtn setHidden:NO];
    [_startBtn setHidden:YES];

    [_tokenTxtBox setText:[obj objectForKey:@"oauth_verifier"]];
    [_tokenTxtBox setText:[obj objectForKey:@"qqn://fitbit?oauth_token"]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
