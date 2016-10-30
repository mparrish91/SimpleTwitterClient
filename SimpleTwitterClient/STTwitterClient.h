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
//@property (nonatomic, copy) void (^successHandler)(void);
//@property (nonatomic, copy) SuccessHandler successHandler;

@property (nonatomic, copy) FailureHandler failureHandler;


- (void)handleOpenURL:(NSURL *)url;
- (void)login:(SuccessHandler)success failure:(FailureHandler)failure;


+ (instancetype)sharedInstance;


@end
