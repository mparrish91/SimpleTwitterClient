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


- (void)login:(successHandler)success failure:(failureHandler)failure
{
    [[STTwitterClient sharedInstance] deauthorize];
    [[STTwitterClient sharedInstance] fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"twitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"I got a token!");
        
        NSString *string = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
        NSURL *authorizeURL = [NSURL URLWithString:string];
        
        [[UIApplication sharedApplication] openURL:authorizeURL options:@{} completionHandler:nil];
        
        success(nil);

    } failure:^(NSError *error) {
        NSLog(@"%@", [NSString stringWithFormat:@"error %@", [error localizedDescription]]);
        failure(error);
        
    }];
    
}

- (void)handleOpenURL:(NSURL *)url completion:(void (^)(void))completionBlock errorBlock:(successCompletion)errorBlock

{
    BDBOAuth1Credential *requestToken = [[BDBOAuth1Credential alloc]initWithQueryString:url.query];
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:requestToken success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"I got the access token!");
        
        completionBlock();

        
        } failure:^(NSError *error) {
            NSLog(@"Unable to get data");
            errorBlock(error);

        }];

}

- (void)currentAccount:(NSURL *)url
{
        //get User info
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            NSLog(@"%@", responseObject);
            if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                STUser *user = [[STUser alloc]initWithServerRepresentation:responseObject];
                NSLog(@"%@", user);
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Unable to get data");
            
        }];
}



- (void)homeTimeline:(successHandler)success failure:(failureHandler)failure
{
        [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

            NSArray *tweets = [STTweet tweetsWithArray:responseObject];
            success(tweets);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Unable to get data");
            failure(error);

        }];
}


@end
