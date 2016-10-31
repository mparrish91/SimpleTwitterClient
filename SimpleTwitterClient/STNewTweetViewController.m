//
//  STNewTweetViewController.m
//  SimpleTwitterClient
//
//  Created by parry on 10/30/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STNewTweetViewController.h"
#import "STTwitterClient.h"
#import "STUser.h"
#import "UIImageView+AFNetworking.h"

@interface STNewTweetViewController ()

@property(strong,nonatomic) STUser *user;


@end

@implementation STNewTweetViewController


- (instancetype)init
{
    self.nameLabel = [[UILabel alloc]init];
    self.usernameLabel = [[UILabel alloc]init];
    self.profilePhotoImageView = [[UIImageView alloc]init];
    self.tweetTextView = [[UITextView alloc] init];
    
    
    self = [super init];
    if(self) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"  style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButtonPressed)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet"  style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButtonPressed)];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(120, 1, 150, 40)];
    self.textCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 1, 150, 40)];
    self.textCountLabel.text = @"140";
    self.textCountLabel.textColor = [UIColor whiteColor];
    self.textCountLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:self.textCountLabel];
//    self.navigationItem.titleView = view;
    [self.navigationController.navigationBar addSubview:view];

    [self fetchUser];
    [self setConstraints];
    
    

}

- (void)fetchUser
{
    STTwitterClient *client = [STTwitterClient sharedInstance];
    [client currentAccount:^(id responseObject) {
        
        if([responseObject isKindOfClass:[STUser class]])
        {
            self.user = responseObject;
            self.nameLabel.text = [self.user name];
            self.usernameLabel.text = [NSString stringWithFormat:@"@%@",[self.user username]];
            
            NSURL *photoImageURL = [self.user profilePhotoURL];
            
            [self.profilePhotoImageView setImageWithURL:photoImageURL placeholderImage:[UIImage imageNamed:@"placeholder-background"]];

        }
        
    } failure:^(NSError *error) {
        
    }];

}

- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view addSubview:self.nameLabel];
    [view addSubview:self.usernameLabel];
    [view addSubview:self.profilePhotoImageView];
    [view addSubview:self.tweetTextView];
    
    view.backgroundColor = [UIColor whiteColor];
    self.tweetTextView.backgroundColor = [UIColor redColor];

}



-(void)setConstraints
{
    
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];

    
    self.profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.profilePhotoImageView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor constant:5].active = YES;
    [self.profilePhotoImageView.heightAnchor constraintEqualToConstant:30].active = YES;
    [self.profilePhotoImageView.widthAnchor constraintEqualToConstant:30].active = YES;
    [self.profilePhotoImageView.topAnchor constraintEqualToAnchor:margins.topAnchor constant:5].active = YES;
    
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.profilePhotoImageView.trailingAnchor constant:2].active = YES;
    [self.nameLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.profilePhotoImageView.topAnchor].active = YES;
    self.nameLabel.font = [UIFont fontWithName:@"Avenir-Book" size:7];

    
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.usernameLabel.leadingAnchor constraintEqualToAnchor:self.nameLabel.leadingAnchor].active = YES;
    [self.usernameLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.usernameLabel.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor constant:1].active = YES;
    self.usernameLabel.font = [UIFont fontWithName:@"Avenir-Book" size:6];

    
    self.tweetTextView.translatesAutoresizingMaskIntoConstraints = false;
    [self.tweetTextView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.usernameLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.tweetTextView.topAnchor constraintEqualToAnchor:self.profilePhotoImageView.bottomAnchor].active = YES;
    [self.tweetTextView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;

    
}

-(void)onCancelButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)onTweetButtonPressed {
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSInteger length = [textView.text length];
    
    if ((int)length <= 140)
    {
        self.textCountLabel.text = [NSString stringWithFormat:@"%ld", (long)length];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return textView.text.length + (text.length - range.length) <= 140;
}
@end
