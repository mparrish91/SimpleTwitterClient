//
//  AppDelegate.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "AppDelegate.h"
#import "STLoginViewController.h"
#import "BDBOAuth1SessionManager.h"
#import "STUser.h"
#import "STTweet.h"
#import "STTwitterClient.h"
#import "STHomeViewController.h"



#define twitterUrl @"https://api.twitter.com"
#define key @"4TkmfVHsaCscvmG98fuJUuIoi"
#define secret @"IuQ2AZVD0VKlR15u0lijO6LCdQbWts38x1MhXdHqlAisOj11o6"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [UINavigationBar appearance].barTintColor = [UIColor lightGrayColor];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];


    
    if (STUser.currentUser != nil)
    {
        NSLog(@"there is a current user");
        STHomeViewController *homeVC = [[STHomeViewController alloc]init];
        UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:homeVC];
        
        self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.window setRootViewController:nav2];
        [self.window makeKeyAndVisible];

    }
    else
    {
        NSLog(@"there is not a current user");
        STLoginViewController *loginVC =[[STLoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        
        self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.window setRootViewController:nav];
        [self.window makeKeyAndVisible];

    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(presentLoginVC)
                                                 name:@"userDidLogout"
                                               object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:@"userDidLogout" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        STLoginViewController *loginVC =[[STLoginViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
//        self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//        [self.window setRootViewController:nav];
//        [self.window makeKeyAndVisible];
//
//    }];
//        
    //set window
    
    return YES;
}


-(void)presentLoginVC
{
    STLoginViewController *loginVC =[[STLoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];

    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        [self.window setRootViewController:nav];
    } completion:^(BOOL finished) {
        
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    STTwitterClient *client = [STTwitterClient sharedInstance];
    [client handleOpenURL:url];

     return YES;
}

@end
