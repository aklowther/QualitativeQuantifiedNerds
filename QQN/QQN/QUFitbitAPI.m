//
//  QUFitbitAPI.m
//  QQN
//
//  Created by Adam Lowther on 2/7/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUFitbitAPI.h"
#import "QURESTManager.h"
#import "OAuth1Controller.h"
#import "PDKeychainBindings.h"

#define OAUTH_CALLBACK       @"http://www.mycallbackurl.com"
#define CONSUMER_KEY         @"8bf7ef0470df4cd5aa7048368eaed517"
#define CONSUMER_SECRET      @"a6b13f6aa8224614804cf4e2691ca259"
#define AUTH_URL             @"https://api.fitbit.com/"
#define REQUEST_TOKEN_URL    @"oauth/request_token"
#define AUTHENTICATE_URL     @"oauth/authorize"
#define ACCESS_TOKEN_URL     @"oauth/access_token"
#define API_URL              @"https://api.fitbit.com/"
#define OAUTH_SCOPE_PARAM    @""
#define REDIRECT_URL         @"https://www.fitbit.com/"
#define REQUEST_TOKEN_METHOD @"POST"
#define ACCESS_TOKEN_METHOD  @"POST"

@implementation QUFitbitAPI

+(NSDictionary *)getUserInfo
{
    NSString *methodURL = @"1/user/-/profile.json";
    
    NSDictionary *headers = @{@"Accept-Language": @"en_US"};
    NSString *oauthToken = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"fitbitToken"];
    NSString *oauthSecret = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"fitbitSecretToken"];
    
    NSURLRequest *request = [OAuth1Controller preparedRequestForHost:API_URL
                                                                path:methodURL
                                                          parameters:headers
                                                          HTTPmethod:@"GET"
                                                          oauthToken:oauthToken
                                                         oauthSecret:oauthSecret
                                                        consumerData:@{@"consumer_secret": CONSUMER_SECRET, @"consumer_key": CONSUMER_KEY}];
    
    
    NSDictionary *returnData = [[QURESTManager sharedManager] doGetWithNSURLRequest:request];
    return returnData;
}

@end
