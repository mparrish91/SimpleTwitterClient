//
//  STLoginViewController.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STLoginViewController.h"
#import "BDBOAuth1SessionManager.h"
//#import "STHomeViewController.h"


#define twitterUrl @"https://api.twitter.com"
#define key @"4TkmfVHsaCscvmG98fuJUuIoi"
#define secret @"IuQ2AZVD0VKlR15u0lijO6LCdQbWts38x1MhXdHqlAisOj11o6"


//@interface STLoginViewController ()
//
//@property(strong,readwrite,nonatomic) UIButton *loginButton;
//
//@end

@implementation STLoginViewController


#pragma mark - Initialize

- (instancetype)init
{

    self.loginButton = [[UIButton alloc]init];
    
    
    if (!(self = [super init]))
        return nil;
    
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.loginButton addTarget:self
                          action:@selector(loginToTwitter)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self setConstraints];
}


- (void)loginToTwitter {
    
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



//    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithMovie:movie];
//    //    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithURL:[movie posterPath]];
//    [self.navigationController pushViewController:detailVC animated:true];



- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;

    [view addSubview:self.loginButton];
}


-(void)setConstraints
{
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    
    self.loginButton.translatesAutoresizingMaskIntoConstraints = false;
    [self.loginButton.centerXAnchor constraintEqualToAnchor:margins.centerXAnchor].active = YES;

    [self.loginButton.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
    [self.loginButton.widthAnchor constraintEqualToConstant:200].active = YES;
    [self.loginButton.heightAnchor constraintEqualToConstant:10].active = YES;

    [self.loginButton setTitle:@"Login to Twitter" forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.loginButton.layer.backgroundColor = [UIColor blueColor].CGColor;

    
}




@end
