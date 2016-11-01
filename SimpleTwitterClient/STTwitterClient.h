//
//  STTwitterClient.h
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDBOAuth1SessionManager.h"


typedef void (^SuccessHandler)(id responseObject);
typedef void(^FailureHandler)(NSError *error);


@interface STTwitterClient : BDBOAuth1SessionManager

@property (nonatomic, copy) void (^successHandler)(id responseObject);

@property (nonatomic, copy) FailureHandler failureHandler;


- (void)handleOpenURL:(NSURL *)url;
- (void)login:(SuccessHandler)success failure:(FailureHandler)failure;
- (void)homeTimeline:(SuccessHandler)success failure:(FailureHandler)failure;
- (void)currentAccount:(SuccessHandler)success failure:(FailureHandler)failure;
- (void)logout;
- (void)sendNewPost: (NSString *)content success:(SuccessHandler)success failure:(FailureHandler)failure;


+ (instancetype)sharedInstance;


@end
