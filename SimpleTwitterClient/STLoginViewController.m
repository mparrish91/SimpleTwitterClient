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
#import "STTwitterClient.h"


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
    STTwitterClient *client = [STTwitterClient sharedInstance];
    [client login:^(id responseObject) {
        NSLog(@"login success");
    } failure:^(NSError *error) {
        
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
