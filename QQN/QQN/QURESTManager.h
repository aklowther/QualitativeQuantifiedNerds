//
//  QURESTManager.h
//  QQN
//
//  Created by Adam Lowther on 2/7/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLayoutUpdated @"LayoutUpdated"

typedef void (^CompletionBlock)(NSDictionary *parsedResults, NSError *err);

@interface QURESTManager : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong) NSString *baseUrlString;

@property (nonatomic, strong) NSString *companyJsonNameToUse;
@property (nonatomic, strong) NSString *modulesJsonNameToUse;
@property (nonatomic, strong) NSError *lastError;

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *deviceType;
@property (nonatomic, strong) NSString *iosVersion;

@property (nonatomic, assign) BOOL cacheCredentialsInMemoryOnly;

+(QURESTManager *)sharedManager;

-(BOOL)hasTokenForSource:(NSString*)source;
//-(void)destroyToken;
-(void)setTokensForSource:(NSDictionary *)data;
-(NSDictionary *)getTokensForSource:(NSString*)source;
//-(NSDictionary*)loadCredentials;
//-(void)deleteCredentials;
//-(void)saveCredentials:(NSDictionary *)credentials;

//-(NSDictionary *)doGetFromURL:(NSURL *)url withHeaders:(NSDictionary *)headers;
-(NSDictionary *)doGetWithNSURLRequest:(NSURLRequest*)getRequest;

-(void)loginWithUsername:(NSString *)userName andPassword:(NSString *)passwd completion:(CompletionBlock)completion;

//-(void)setupInfoWithAuthToken:(NSString *)authToken ifModifiedSince:(NSDate *)sinceDate completion:(CompletionBlock)completion;
-(void)saveUserToken:(NSString *)token secret:(NSString *)secret;


@end
