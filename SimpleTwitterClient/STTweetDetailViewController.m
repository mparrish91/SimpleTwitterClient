//
//  STTweetDetailViewController.m
//  SimpleTwitterClient
//
//  Created by parry on 10/30/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STTweetDetailViewController.h"
#import "STTweetDetailView.h"
#import "STTweet.h"

@interface STTweetDetailViewController ()
@property(strong,nonatomic) STTweetDetailView *detailView;
@end

@implementation STTweetDetailViewController


#pragma mark - Initialize

- (instancetype)initWithTweet:(STTweet *)tweet
{
    self.detailView = [[STTweetDetailView alloc]initWithTweet: tweet];
    
    
    if (!(self = [super init]))
        return nil;
    
    
    return  self;
    
}




#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setConstraints];
    
    
    
}

- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // add subviews
    self.view = view;
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.detailView];
    
}


#pragma mark - AutoLayout

-(void)setConstraints
{
    
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    self.detailView.translatesAutoresizingMaskIntoConstraints = false;
    [self.detailView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.detailView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.detailView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.detailView.heightAnchor constraintEqualToConstant:350].active = YES;
    self.detailView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    self.detailView.contentMode = UIViewContentModeScaleAspectFit;
    
}


@end
