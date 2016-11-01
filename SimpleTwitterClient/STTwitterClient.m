//
//  PTTwitterClient.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STTwitterClient.h"
#import "BDBOAuth1SessionManager.h"
#import "STUser.h"
#import "STTweet.h"
#import "STLoginViewController.h"


#define twitterUrl @"https://api.twitter.com"
#define key @"4TkmfVHsaCscvmG98fuJUuIoi"
#define secret @"IuQ2AZVD0VKlR15u0lijO6LCdQbWts38x1MhXdHqlAisOj11o6"


@implementation STTwitterClient



+ (instancetype)sharedInstance
{
    static STTwitterClient *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:twitterUrl];
        sharedInstance = [[STTwitterClient alloc]initWithBaseURL:url consumerKey:key consumerSecret:secret];
    });
    return sharedInstance;
}


- (void)login:(SuccessHandler)success failure:(FailureHandler)failure
{
    
    self.successHandler = success;
    self.failureHandler = failure;
    
    [[STTwitterClient sharedInstance] deauthorize];
    [[STTwitterClient sharedInstance] fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"twitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"I got a token!");
        
        NSString *string = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
        NSURL *authorizeURL = [NSURL URLWithString:string];
        
        [[UIApplication sharedApplication] openURL:authorizeURL options:@{} completionHandler:nil];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", [NSString stringWithFormat:@"error %@", [error localizedDescription]]);
        failure(error);
        
    }];
    
}

- (void)logout
{
    STUser.currentUser = nil;
    [self deauthorize];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"userDidLogout"
     object:self];

}


- (void)handleOpenURL:(NSURL *)url

{
    BDBOAuth1Credential *requestToken = [[BDBOAuth1Credential alloc]initWithQueryString:url.query];
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:requestToken success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"I got the access token!");
        
        [self currentAccount:^(id responseObject) {
            
        if([responseObject isKindOfClass:[STUser class]])
            STUser.currentUser = responseObject;
    
            if (self.successHandler)
                self.successHandler(nil);
        } failure:^(NSError *error) {
            if (self.failureHandler)
                self.failureHandler(error);
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"Unable to get data");
        
        if (self.failureHandler)
            self.failureHandler(error);
        
        
    }];
    
}

- (void)currentAccount:(SuccessHandler)success failure:(FailureHandler)failure
{
        //get User info
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            NSLog(@"%@", responseObject);
            if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                STUser *user = [[STUser alloc]initWithServerRepresentation:responseObject];
                success(user);

            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Unable to get data");
            failure(error);

        }];
}



- (void)homeTimeline:(SuccessHandler)success failure:(FailureHandler)failure
{
        [self GET:@"https://api.twitter.com/1.1/statuses/home_timeline.json?count=20" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

            NSArray *tweets = [STTweet tweetsWithArray:responseObject];
            success(tweets);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Unable to get data");
            failure(error);

        }];
}

- (void)sendNewPost: (NSString *)content success:(SuccessHandler)success failure:(FailureHandler)failure
{
    NSDictionary *message = @{@"status" : content};
    NSString *requestString = @"https://api.twitter.com/1.1/statuses/update.json";

    [self POST:requestString parameters:message success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"Twitter HTTP response %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Twitter HTTP response %@", error.localizedDescription);

    }];
    
}



@end
