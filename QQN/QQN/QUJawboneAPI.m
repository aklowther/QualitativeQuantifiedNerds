//
//  QUJawboneAPI.m
//  QQN
//
//  Created by Adam Lowther on 2/9/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUJawboneAPI.h"

#define qACCOUNT_TYPE @"jawboneService"

@implementation QUJawboneAPI

+(void)initAuth
{
    for (NXOAuth2Account *account in [[NXOAuth2AccountStore sharedStore] accountsWithAccountType:@"jawboneService"]) {
        [[NXOAuth2AccountStore sharedStore] removeAccount:account];
    };
    
    [[NXOAuth2AccountStore sharedStore] setClientID:@"c79vN7QBQ0Q"
                                             secret:@"24fea2c29437a852db4bc507811f7a536b815167"
                                              scope:[NSSet setWithObjects:@"basic_read", @"extended_read", @"move_read", @"sleep_read", @"meal_read", nil]
                                   authorizationURL:[NSURL URLWithString:@"https://jawbone.com/auth/oauth2/auth"]
                                           tokenURL:[NSURL URLWithString:@"https://jawbone.com/auth/oauth2/token"]
                                        redirectURL:[NSURL URLWithString:@"qqn://jawbone"]
                                     forAccountType:qACCOUNT_TYPE];
}

+(void)requestAcessUsingViewController:(UIWebView*)webView
{
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:qACCOUNT_TYPE
                                   withPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
                                       [webView loadRequest:[NSURLRequest requestWithURL:preparedURL]];
                                   }];
}

@end
