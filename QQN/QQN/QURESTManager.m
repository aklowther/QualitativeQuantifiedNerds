//
//  QURESTManager.m
//  QQN
//
//  Created by Adam Lowther on 2/7/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QURESTManager.h"
#import "PDKeychainBindings.h"

#define fitbitBaseURL @"https://api.fitbit.com"

@interface QURESTManager ()

@property (nonatomic, strong) NSDictionary *cachedCredentials;

@property (nonatomic, strong) NSString *cachedToken;
@property (nonatomic, strong) NSOperationQueue *opQueue;
@property (nonatomic, strong) NSDictionary *positionStatuses;

@property (nonatomic, assign) BOOL isDone;
@property (nonatomic, assign) BOOL didFail;
@property (nonatomic, strong) NSMutableData *fetchedData;
@property (nonatomic, strong) NSHTTPURLResponse *response;

// debugging for 401/403 error
@property (nonatomic, assign) BOOL throw401error;
@property (nonatomic, assign) BOOL throw403error;

@property (nonatomic, strong) NSString *authToken;

@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, strong) NSString *acceptEncoding;
@property (nonatomic, strong) NSString *receiveEncoding;
@property (nonatomic, assign) NSInteger expectedContentLength;
@property (nonatomic, assign) NSInteger downloadedContentLength;

@end

@implementation QURESTManager

+(QURESTManager *)sharedManager
{
    static dispatch_once_t token = 0;
    static QURESTManager *mgr = nil;
    dispatch_once( &token, ^{
        mgr = [[QURESTManager alloc] init];
        mgr.baseUrlString = fitbitBaseURL;
        
        mgr.deviceType = [[UIDevice currentDevice] model];
        mgr.iosVersion = [UIDevice currentDevice].systemVersion;
        mgr.appName = @"Q2U";
        mgr.appVersion = [NSString stringWithFormat:@"Version %@ (%@)", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    });
    return mgr;
}

-(NSString *)userAgent
{
    return [NSString stringWithFormat:@"%@/%@ %@/%@", self.deviceType, self.iosVersion, self.appName, self.appVersion];
}

#pragma mark - Network/WebAPI Ops

/***
 general HTTP methods
 ***/

#pragma mark - POST requestor

-(NSDictionary *)doPostToURL:(NSURL *)url withHeaders:(NSDictionary *)headers andBody:(NSData *)postData
{
    NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    postRequest.HTTPMethod = @"POST";
    
    postRequest.HTTPBody = postData;
    //    [postRequest addValue:@"true" forHTTPHeaderField:@"directAuth"];
    [postRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *userAgent = [self userAgent];
    [postRequest addValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self startImmediately:YES];
#pragma unused(connection)
    
    self.isDone = NO;
    self.didFail = NO;
    
    while(!self.isDone)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    NSMutableDictionary *resultsDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSInteger httpStatusCode = _response.statusCode;
    if(_throw403error)
        httpStatusCode = 403;
    
    if(NO == self.didFail)
    {
        NSError *error = nil;
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:self.fetchedData options:kNilOptions error:&error];
        
        resultsDictionary[@"failed"] = @(NO);
        resultsDictionary[@"httpstatus"] = @(httpStatusCode);
        if(nil != dataDict)
            resultsDictionary[@"data"] = dataDict;
    }
    else
    {
        resultsDictionary[@"failed"] = @(YES);
        resultsDictionary[@"error"] = _lastError;
    }
    
    connection = nil;
    return resultsDictionary;
}

#pragma mark - GET requestor

// add logging

-(NSDictionary *)doGetFromURL:(NSURL *)url withHeaders:(NSDictionary *)headers
{
    NSMutableURLRequest *getRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    getRequest.HTTPMethod = @"GET";
    
    NSMutableDictionary *httpHeaders = [NSMutableDictionary dictionaryWithDictionary:getRequest.allHTTPHeaderFields];
    if (headers != nil) {
        [httpHeaders addEntriesFromDictionary:headers];
    }
    
    //    NSString *userAgent = [self userAgent];
    
    [getRequest setAllHTTPHeaderFields:httpHeaders];
    
    getRequest.timeoutInterval = 120;
    
    [getRequest setCachePolicy: NSURLRequestReloadIgnoringLocalCacheData];
    
    return [self doGetWithNSURLRequest:getRequest];
}

-(NSDictionary *)doGetWithNSURLRequest:(NSURLRequest*)getRequest
{
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:getRequest delegate:self startImmediately:YES];
#pragma unused(connection)
    
    self.isDone = NO;
    self.didFail = NO;
    
    while(!self.isDone)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    NSMutableDictionary *resultsDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if(NO == self.didFail)
    {
        NSString *fetchedString = [[NSString alloc] initWithData:self.fetchedData encoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        NSInteger httpStatusCode = _response.statusCode;
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:self.fetchedData options:kNilOptions error:&error];
        resultsDictionary[@"fetchedDataSize"] = @(self.fetchedData.length);
        if(200 == httpStatusCode)
        {
            if(nil == dataDict)
            {
                _lastError = error;
                resultsDictionary[@"failed"] = @(YES);
                resultsDictionary[@"rawdata"] = fetchedString;
                resultsDictionary[@"error"] = _lastError;
            }
            else
            {
                resultsDictionary[@"failed"] = @(NO);
                resultsDictionary[@"httpstatus"] = @(httpStatusCode);
                resultsDictionary[@"data"] = dataDict;
            }
            resultsDictionary[@"httpHeaders"] = [_response allHeaderFields];
        }
        else
            if(500 == httpStatusCode || 503 == httpStatusCode || 403 == httpStatusCode)
            {
                resultsDictionary[@"failed"] = @(NO);
                resultsDictionary[@"httpstatus"] = @(httpStatusCode);
                resultsDictionary[@"httpHeaders"] = [_response allHeaderFields];
            }
            else
            {
                resultsDictionary[@"data"] = dataDict;
                resultsDictionary[@"failed"] = @(NO);
                resultsDictionary[@"httpstatus"] = @(httpStatusCode);
                resultsDictionary[@"httpHeaders"] = [_response allHeaderFields];
            }
    }
    else
    {
        resultsDictionary[@"failed"] = @(YES);
        resultsDictionary[@"error"] = _lastError;
    }
    
    connection = nil;
    return resultsDictionary;
}

#pragma mark - token and credentials

-(BOOL)hasTokenForSource:(NSString*)source
{
    NSDictionary *tokensPacket = [self getTokensForSource:source];
    return (tokensPacket != nil);
}

-(NSString *)tokenPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [NSString stringWithFormat:@"%@/token.plist", paths[0]];
}

-(NSString *)credentialsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [NSString stringWithFormat:@"%@/credentials.plist", paths[0]];
}

-(void)destroyTokens
{
    [[NSFileManager defaultManager] removeItemAtPath:[self tokenPath] error:nil];
    _authToken = nil;
}

-(void)setTokensForSource:(NSDictionary *)data
{
    if (data != nil) {
        NSString *source = data[@"source"];
        PDKeychainBindings *binding = [PDKeychainBindings sharedKeychainBindings];
        NSString *tokenKey = [NSString stringWithFormat:@"%@Token", source];
        if ([binding stringForKey:tokenKey] != nil) {
            [binding removeObjectForKey:tokenKey];
        }
        [binding setString:data[@"token"] forKey:tokenKey];
        
        NSString *tokenSecret = [NSString stringWithFormat:@"%@SecretToken", source];
        if ([binding stringForKey:tokenSecret] != nil) {
            [binding removeObjectForKey:tokenSecret];
        }
        [binding setString:data[@"secretToken"] forKey:tokenSecret];
    }
}

-(NSDictionary *)getTokensForSource:(NSString*)source
{
    NSString *token = [[PDKeychainBindings sharedKeychainBindings] stringForKey:[NSString stringWithFormat:@"%@Token", source]];
    NSString *secretToken = [[PDKeychainBindings sharedKeychainBindings] stringForKey:[NSString stringWithFormat:@"%@SecretToken", source]];
    NSDictionary *returnTokens = [NSDictionary dictionaryWithObjects:@[token, secretToken] forKeys:@[@"token", @"secretToken"]];
    return returnTokens;
}

-(void)deleteCredentials
{
    if(_cacheCredentialsInMemoryOnly)
    {
        self.cachedCredentials = @{@"Username":@"", @"Password":@""};
    }
    else
    {
        PDKeychainBindings *bindings=[PDKeychainBindings sharedKeychainBindings];
        [bindings setObject:@"" forKey:@"Username"];
        [bindings setObject:@"" forKey:@"Password"];
        [bindings setObject:@"" forKey:@"userID"];
    }
    [self destroyToken];
}

-(void)saveCredentials:(NSDictionary *)credentials
{
    if(nil != credentials)
    {
        if(_cacheCredentialsInMemoryOnly)
        {
            self.cachedCredentials = [[NSDictionary alloc] initWithDictionary:credentials];
        } else {
            PDKeychainBindings *bindings=[PDKeychainBindings sharedKeychainBindings];
            [bindings setObject:credentials[@"Username"] forKey:@"Username"];
            [bindings setObject:credentials[@"Password"] forKey:@"Password"];
            [bindings setObject:credentials[@"userID"] forKey:@"userID"];
        }
    }
}

-(NSDictionary *)loadCredentials
{
    NSDictionary *credentials = nil;
    if(_cacheCredentialsInMemoryOnly)
    {
        credentials = self.cachedCredentials;
    }
    else
    {
        PDKeychainBindings *bindings=[PDKeychainBindings sharedKeychainBindings];
        
        NSString *emailStr = [bindings objectForKey:@"Username"];
        NSString *passwordStr = [bindings objectForKey:@"Password"];
        NSString *userIDStr = [bindings objectForKey:@"userID"];
        
        credentials = @{
                        @"Username" : (nil != emailStr)?emailStr:@"",
                        @"Password" : (nil != passwordStr)?passwordStr:@"",
                        @"userID" : (nil != passwordStr)?userIDStr:@""
                        };
    }
    return credentials;
}

/***
 API-call-specific methods
 ***/

#pragma mark - login

//TODO - add retry logic in here.  retry if we get a 500 or 503 back from the API every NN
// seconds for up to MM tries.

-(void)loginWithUsername:(NSString *)userName andPassword:(NSString *)passwd completion:(CompletionBlock)completion
{
    NSInteger numRetries = 0;
    NSInteger retryInterval = 5;
    
    //    self.comboIsRunning = YES;
    NSURL *loginURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@authenticateUser", self.baseUrlString]];
    
    NSDictionary *credentialsDictionary = @{@"email":userName, @"password":passwd, @"directAuth":@"TRUE"};
    
    NSMutableString *credentialsString = [NSMutableString string];
    [credentialsDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        [credentialsString appendString:[NSString stringWithFormat:@"%@=%@&", (NSString*)key, (NSString*)obj]];
    }];
    
    NSData *postData = [credentialsString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:credentials options:NSJSONWritingPrettyPrinted error:nil];
    
#define RETRY_LOGIC 1
#ifdef RETRY_LOGIC
    NSDictionary *loginResults = nil;
    BOOL done = NO;
    do {
        //        loginResults = [self doPostToURL:loginURL withHeaders:@{@"Content-Type":@"application/json"} andBody:jsonData];
        loginResults = [self doPostToURL:loginURL withHeaders:@{@"Content-Type":@"application/x-www-form-urlencoded"} andBody:postData];
        if(NO == [loginResults[@"failed"] boolValue])
        {
            NSInteger httpStatus = [loginResults[@"httpstatus"] integerValue];
            if(500 == httpStatus || 503 == httpStatus)
            {
                if(numRetries<3)
                {
                    sleep(retryInterval);
                    numRetries++;
                }
                else
                {
                    done = YES;
                }
            }
            else
                done = YES;
        }
        else
        {
            done = YES;
        }
    } while(!done);
#else
    NSDictionary *loginResults = [self doPostToURL:loginURL withHeaders:@{@"Content-Type":@"application/x-www-form-urlencoded"} andBody:jsonData];
    
    if([@(NO) isEqualToNumber:loginResults[@"failed"]])
    {
        if(nil != loginResults[@"httpstatus"] && [@(200) isEqualToNumber:loginResults[@"httpstatus"]])
        {
            if(nil != loginResults[@"data"][@"status"] && [@(0) isEqualToNumber:loginResults[@"data"][@"status"]])
            {
                self.authToken = loginResults[@"data"][@"authtoken"];
                [self saveToken];
            }
        }
    }
#endif
    
    if(nil != completion)
    {
        completion( loginResults, loginResults[@"error"]);
    }
    
    //    self.comboIsRunning = NO;
}

//-(void)setupInfoWithAuthToken:(NSString *)authToken ifModifiedSince:(NSDate *)sinceDate completion:(CompletionBlock)completion
//{
//    // dispatch block on operation queue
//    NSURL *setupURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/setup", self.baseUrlString]];
//
//    NSMutableDictionary *requestHeaders = [NSMutableDictionary dictionaryWithDictionary:@{
//                                                                                          @"Authorization" : [NSString stringWithFormat:@"Bearer %@", (nil != authToken)?authToken:@""],
//                                                                                          @"User-Agent" : [self userAgent],
//                                                                                          @"If-Modified-Since" : [self.myFormatter formatModifiedDate:sinceDate]
//                                                                                          }];
//
//    NSDictionary *setupResults = nil;
//    BOOL done = NO;
//    NSInteger retryCount = 0;
//    NSInteger numRetries = 3;
//    do {
//        setupResults = [self doGetFromURL:setupURL withHeaders:requestHeaders];
//        NSInteger httpStatus = [setupResults[@"httpstatus"] integerValue];
//        if(200 == httpStatus)
//        {
//            done = YES;
//        }
//        else
//            if(401 == httpStatus)
//            {
//                NSDictionary *creds = [self loadCredentials];
//                __block NSDictionary *loginResults;
//                __block NSError *error = nil;
//                [self loginWithUsername:creds[@"Username"] andPassword:creds[@"Password"] completion:^(NSDictionary *parsedResults, NSError *err){
//                    loginResults = parsedResults;
//                    error = err;
//                }];
//                httpStatus = [loginResults[@"httpstatus"] integerValue];
//                if(200 != httpStatus)
//                {
//                    done = YES;
//                    setupResults = loginResults;
//                }
//                else
//                {
//                    NSString *authToken = loginResults[@"data"][@"AuthToken"];
//                    requestHeaders[@"Authorization"] = [NSString stringWithFormat:@"Bearer %@", (nil != authToken)?authToken:@""];
//                }
//                creds = nil;
//            }
//            else
//                if(500 == httpStatus || 503 == httpStatus)
//                {
//                    retryCount++;
//                    if(retryCount>numRetries)
//                        done = YES;
//                }
//                else
//                {
//                    done = YES;
//                }
//    } while(!done);
//
//    if(nil != completion)
//    {
//        completion( setupResults, setupResults[@"error"]);
//    }
//}

#pragma mark - modules

//-(void)moduleListWithAuthToken:(NSString *)authToken ifModifiedSince:(NSDate *)sinceDate completion:(CompletionBlock)completion
//{
//    NSURL *modulesURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/modules", self.baseUrlString]];
//
//    NSMutableDictionary *requestHeaders = [NSMutableDictionary dictionaryWithDictionary:@{
//                                                                                          @"Authorization" : [NSString stringWithFormat:@"Bearer %@", (nil != authToken)?authToken:@""],
//                                                                                          @"User-Agent" : [self userAgent],
//                                                                                          @"If-Modified-Since" : [self.myFormatter formatModifiedDate:sinceDate]
//                                                                                          }];
//
//    NSDictionary *modulesResults = nil;
//    BOOL done = NO;
//    NSInteger retryCount = 0;
//    NSInteger numRetries = 3;
//    do {
//        modulesResults = [self doGetFromURL:modulesURL withHeaders:requestHeaders];
//        NSInteger httpStatus = [modulesResults[@"httpstatus"] integerValue];
//        if(200 == httpStatus)
//        {
//            done = YES;
//        }
//        else
//            if(401 == httpStatus)
//            {
//                NSDictionary *creds = [self loadCredentials];
//                __block NSDictionary *loginResults;
//                __block NSError *error = nil;
//                [self loginWithUsername:creds[@"Username"] andPassword:creds[@"Password"] completion:^(NSDictionary *parsedResults, NSError *err){
//                    loginResults = parsedResults;
//                    error = err;
//                }];
//                httpStatus = [loginResults[@"httpstatus"] integerValue];
//                if(200 != httpStatus)
//                {
//                    done = YES;
//                    modulesResults = loginResults;
//                }
//                else
//                {
//                    NSString *authToken = loginResults[@"data"][@"AuthToken"];
//                    requestHeaders[@"Authorization"] = [NSString stringWithFormat:@"Bearer %@", (nil != authToken)?authToken:@""];
//                }
//                creds = nil;
//            }
//            else
//                if(500 == httpStatus || 503 == httpStatus)
//                {
//                    retryCount++;
//                    if(retryCount>numRetries)
//                        done = YES;
//                }
//                else
//                {
//                    done = YES;
//                }
//    } while(!done);
//
//    if(nil != completion)
//    {
//        completion( modulesResults, modulesResults[@"error"]);
//    }
//}

//-(NSDictionary*)getWODsForCalendarWeek:(NSString*)dateString
//{
////    [self doGetFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@gymScheduleSelect2", kBaseURL]] withHeaders:<#(NSDictionary *)#>]
//}

#pragma mark - NSURLConnection delegate / data methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.fetchedData = [[NSMutableData alloc] init];
    [self.fetchedData setLength:0];
    self.response = (NSHTTPURLResponse *)response;
    //    NSInteger expectedContentLength = (NSInteger)[response expectedContentLength];
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.fetchedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.fetchedData setLength:0];
    self.lastError = error;
    self.isDone = YES;
    self.didFail = YES;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.isDone = YES;
    self.didFail = NO;
}

@end
