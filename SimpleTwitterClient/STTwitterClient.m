//
//  PTTwitterClient.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STTwitterClient.h"

#define twitterUrl @"https://api.twitter.com"
#define key @"4TkmfVHsaCscvmG98fuJUuIoi"
#define secret @"IuQ2AZVD0VKlR15u0lijO6LCdQbWts38x1MhXdHqlAisOj11o6"


@implementation STTwitterClient


-(id)init {
    if (self = [super init]) {
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static STTwitterClient *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[STTwitterClient alloc] init];
    });
    return sharedInstance;
}

- (void)login:(void (^)(NSArray *objects, NSError *error))completionHandler
{
    
    NSURL *url = [NSURL URLWithString:twitterUrl];
    
    BDBOAuth1SessionManager *twitterClient = [[BDBOAuth1SessionManager alloc]initWithBaseURL:url consumerKey:key consumerSecret:secret];
    
    [twitterClient deauthorize];
    [twitterClient fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"twitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"I got a token!");
        
        NSString *string = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
        NSURL *authorizeURL = [NSURL URLWithString:string];
        
        [[UIApplication sharedApplication] openURL:authorizeURL options:@{} completionHandler:nil];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", [NSString stringWithFormat:@"error %@", [error localizedDescription]]);
        
    }];
    
   }

- (void)handleOpenURL:(NSURL *)url completion:(void (^)(void))completionBlock errorBlock:(successCompletion)errorBlock

{
    DBOAuth1Credential *requestToken = [[BDBOAuth1Credential alloc]initWithQueryString:url.query];
    BDBOAuth1SessionManager *twitterClient = [[BDBOAuth1SessionManager alloc]initWithBaseURL:[NSURL URLWithString:twitterUrl] consumerKey:key consumerSecret:secret];
    
    
    [twitterClient fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:requestToken success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"I got the access token!");
        
        completionBlock();

        
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Unable to get data");
            errorBlock(error);
            
            

        }];
        
        


}

- (void)currentAccount
{
    DBOAuth1Credential *requestToken = [[BDBOAuth1Credential alloc]initWithQueryString:url.query];
    BDBOAuth1SessionManager *twitterClient = [[BDBOAuth1SessionManager alloc]initWithBaseURL:[NSURL URLWithString:twitterUrl] consumerKey:key consumerSecret:secret];
    
    [twitterClient fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:requestToken success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"I got the access token!");
        
        //get User info
        [twitterClient GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            NSLog(@"%@", responseObject);
            if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                STUser *user = [[STUser alloc]initWithServerRepresentation:responseObject];
                NSLog(@"%@", user);
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Unable to get data");
            
        }];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", [NSString stringWithFormat:@"error %@", [error localizedDescription]]);
        
    }];

}



- (void)homeTimeline:(void (^)(NSArray *objects, NSError *error))completionHandler
{
    DBOAuth1Credential *requestToken = [[BDBOAuth1Credential alloc]initWithQueryString:url.query];
    BDBOAuth1SessionManager *twitterClient = [[BDBOAuth1SessionManager alloc]initWithBaseURL:[NSURL URLWithString:twitterUrl] consumerKey:key consumerSecret:secret];
    
    
    [twitterClient fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:requestToken success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"I got the access token!");
        
        //get timeline info
        [twitterClient GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            NSLog(@"%@", responseObject);
            
            NSArray *tweets = [STTweet tweetsWithArray:responseObject];
            NSLog(@"SWEFsa");
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Unable to get data");
            
        }];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", [NSString stringWithFormat:@"error %@", [error localizedDescription]]);
        
    }];

       
}


@end
