//
//  OAuth1Controller.h
//  Simple-OAuth1
//
//  Created by Christian Hansen on 02/12/12.
//  Copyright (c) 2012 Christian-Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuth1Controller : NSObject <UIWebViewDelegate>

- (void)loginWithConsumerData:(NSDictionary*)data
             andStandardOauth:(NSDictionary*)oauthData
            inWebView:(UIWebView *)webWiew
           completion:(void (^)(NSDictionary *oauthTokens, NSError *error))completion;

- (void)requestAccessToken:(NSString *)oauth_token_secret
                oauthToken:(NSString *)oauth_token
             oauthVerifier:(NSString *)oauth_verifier
                completion:(void (^)(NSError *error, NSDictionary *responseParams))completion;

+ (NSURLRequest *)preparedRequestForHost:(NSString*)host
                                    path:(NSString *)path
                              parameters:(NSDictionary *)queryParameters
                              HTTPmethod:(NSString *)HTTPmethod
                              oauthToken:(NSString *)oauth_token
                             oauthSecret:(NSString *)oauth_token_secret
                            consumerData:(NSDictionary*)consumerData;

//+(NSDictionary*)standardOauthParameters;

@end
