//
//  STTwitterClient.h
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDBOAuth1SessionManager.h"


typedef void (^successHandler)(id responseObject);
typedef void(^failureHandler)(NSError *error);

typedef void(^STDataRequestHandler)(id responseObject, NSError *error);

@interface STTwitterClient : BDBOAuth1SessionManager


//- (void)handleOpenURL:(NSURL *)url completion:(void (^)(void))completionBlock ;
//- (void)handleOpenURL:(NSURL *)url completion:(void (^)(void))completionBlock errorBlock:(successCompletion)errorBlock;

- (void)login:(STDataRequestHandler)handler;


//class method
+ (instancetype)sharedInstance;

@property (nonatomic, copy) void (^successHandler)(id responseObject);
@property void(^failureHandler)(NSError *error);

@end
