//
//  STNewTweetViewController.m
//  SimpleTwitterClient
//
//  Created by parry on 10/30/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STNewTweetViewController.h"

@interface STNewTweetViewController ()

@property(strong,readwrite,nonatomic) UILabel *nameLabel;
@property(strong,readwrite,nonatomic) UILabel *usernameLabel;
@property(strong,readwrite,nonatomic) UIImageView *profilePhotoImageView;

@property(strong,readwrite,nonatomic) UITextView *tweetTextView;

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


    [self setConstraints];

}

-(void)setConstraints
{
    
    UIView *view= self.view;
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    
    self.profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.profilePhotoImageView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.profilePhotoImageView.heightAnchor constraintEqualToConstant:3].active = YES;
    [self.profilePhotoImageView.widthAnchor constraintEqualToConstant:30].active = YES;
    [self.profilePhotoImageView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.profilePhotoImageView.trailingAnchor constant:1].active = YES;
    [self.nameLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.profilePhotoImageView.topAnchor].active = YES;
    
    
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.usernameLabel.leadingAnchor constraintEqualToAnchor:self.nameLabel.leadingAnchor constant:1].active = YES;
    [self.usernameLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.usernameLabel.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor constant:1].active = YES;
    
    
    self.tweetTextView.translatesAutoresizingMaskIntoConstraints = false;
    [self.tweetTextView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.usernameLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.tweetTextView.topAnchor constraintEqualToAnchor:self.profilePhotoImageView.bottomAnchor].active = YES;
    [self.tweetTextView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;

}

-(void)onCancelButtonPressed {
    
}

-(void)onTweetButtonPressed {
    
}



@end
