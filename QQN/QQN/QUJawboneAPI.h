//
//  QUJawboneAPI.h
//  QQN
//
//  Created by Adam Lowther on 2/9/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NXOAuth2Client/NXOAuth2.h>


@interface QUJawboneAPI : NSObject

+(void)initAuth;
+(void)requestAcessUsingViewController:(UIWebView*)webView;

@end
