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
    
    
    self.errorView.translatesAutoresizingMaskIntoConstraints = false;
    [self.errorView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.errorView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.errorView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    [self.errorView.heightAnchor constraintEqualToConstant:30].active = YES;
    
}

-(void)onCancelButtonPressed {
    
}

-(void)onTweetButtonPressed {
    
}



@end
