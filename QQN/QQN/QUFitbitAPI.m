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
#import "NSString+URLEncoding.h"

#define OAUTH_CALLBACK       @"http://www.mycallbackurl.com"
#define CONSUMER_KEY         @"fc15da9d5542486cb97c3faf1e6cef88"
#define CONSUMER_SECRET      @"9e9b104950fb4240b4fac6f15a50a535"
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

+(NSDictionary*)getConsumerAppData
{
    NSMutableDictionary *returnData = [NSMutableDictionary dictionary];
    returnData[@"oauth_callback"] = OAUTH_CALLBACK;
    returnData[@"consumer_key"] = CONSUMER_KEY;
    returnData[@"consumer_secret"] = CONSUMER_SECRET;
    returnData[@"auth_url"] = AUTH_URL;
    returnData[@"request_token_url"] = REQUEST_TOKEN_URL;
    returnData[@"authenticate_url"] = AUTHENTICATE_URL;
    returnData[@"access_token_url"] = ACCESS_TOKEN_URL;
    returnData[@"api_url"] = API_URL;
    returnData[@"oauth_scope_param"] = OAUTH_SCOPE_PARAM;
    returnData[@"redirect_url"] = REDIRECT_URL;
    returnData[@"request_token_method"] = REQUEST_TOKEN_METHOD;
    returnData[@"request_token_url"] = REQUEST_TOKEN_URL;
    returnData[@"access_token_method"] = ACCESS_TOKEN_METHOD;
    
    return returnData;
}

+(NSMutableDictionary*)getOAuthData
{
    NSString *oauth_timestamp = [NSString stringWithFormat:@"%i", (NSInteger)[NSDate.date timeIntervalSince1970]];
    NSString *oauth_nonce = [NSString getNonce];
    NSString *oauth_consumer_key = CONSUMER_KEY;
    NSString *oauth_signature_method = @"HMAC-SHA1";
    NSString *oauth_version = @"1.0";
    
    NSMutableDictionary *standardParameters = [NSMutableDictionary dictionary];
    [standardParameters setValue:oauth_consumer_key     forKey:@"oauth_consumer_key"];
    [standardParameters setValue:oauth_nonce            forKey:@"oauth_nonce"];
    [standardParameters setValue:oauth_signature_method forKey:@"oauth_signature_method"];
    [standardParameters setValue:oauth_timestamp        forKey:@"oauth_timestamp"];
    [standardParameters setValue:oauth_version          forKey:@"oauth_version"];

    return standardParameters;
}

+(NSDictionary *)getUserInfo
{
    NSString *methodURL = @"1/user/-/profile.json";
    NSDictionary *userInfo = [self.class getInfoFromFitbitAPI:methodURL];
    return userInfo;
}

+(NSDictionary *)getWaterForDate:(NSDate*)date
{
    //GET /<api-version>/user/-/foods/log/water/date/<date>.<response-format>
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    
    NSString *methodURL = [NSString stringWithFormat:@"1/user/-/foods/log/water/date/%@.json", dateString];
    NSDictionary *userInfo = [self.class getInfoFromFitbitAPI:methodURL];
    return userInfo;
}

+(NSDictionary*) getActivitiesForDate:(NSDate*)date
{
    //GET /<api-version>/user/<user-id>/activities/date/<date>.<response-format>
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    
    NSString *methodURL = [NSString stringWithFormat:@"1/user/-/activities/date/%@.json", dateString];
    NSDictionary *userInfo = [self.class getInfoFromFitbitAPI:methodURL];
    return userInfo;
}

+(NSDictionary*)getInfoFromFitbitAPI:(NSString*)methodURL
{
//    NSDictionary *headers = @{@"Accept-Language": @"en_US"};
    NSDictionary *tokens = [[QURESTManager sharedManager] getTokensForSource:@"fitbit"];
    NSString *oauthToken = tokens[@"token"];
    NSString *oauthSecret = tokens[@"secretToken"];
    
    NSMutableDictionary *consumerData = [self.class getOAuthData];
    [consumerData setObject:CONSUMER_SECRET forKey:@"consumer_secret"];
    NSURLRequest *request = [OAuth1Controller preparedRequestForHost:API_URL
                                                                path:methodURL
                                                          parameters:nil
                                                          HTTPmethod:@"GET"
                                                          oauthToken:oauthToken
                                                         oauthSecret:oauthSecret
                                                        consumerData:consumerData];
    
    
    
    
    NSDictionary *returnData = [[QURESTManager sharedManager] doGetWithNSURLRequest:request];
    return returnData;
}


@end
