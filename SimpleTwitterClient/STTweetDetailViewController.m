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
#import "STNewTweetViewController.h"
#import "STTwitterClient.h"

@interface STTweetDetailViewController ()
@property(strong,nonatomic) STTweetDetailView *detailView;
@end

@implementation STTweetDetailViewController


#pragma mark - Initialize

- (instancetype)initWithTweet:(STTweet *)tweet
{
    self.detailView = [[STTweetDetailView alloc]initWithTweet: tweet];
    self.detailView.delegate = self;
    
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
    
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
}


//STTweetDetailViewCellDelegate

-(void)stTweetDetailReplyButtonDidChange:(STTweet *)tweet value:(BOOL)value
{
    STNewTweetViewController *newTweetVC = [[STNewTweetViewController alloc]init];
    newTweetVC.tweetTextView.text = @"@%@",[tweet userName];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:newTweetVC];
    [self.navigationController presentViewController:nav animated:true completion:nil];
    
}

-(void)stTweetDetailReTweetButtonDidChange:(STTweet *)tweet value:(BOOL)value
{
    STTwitterClient *client = [STTwitterClient sharedInstance];
    [client reTweet:[tweet id] success:^(id responseObject) {
        NSLog(@"Sucess");
    } failure:^(NSError *error) {
        NSLog(@"error");
        
    }];
    
}

-(void)stTweetDetailFavoriteButtonDidChange:(STTweet *)tweet value:(BOOL)value
{
    STTwitterClient *client = [STTwitterClient sharedInstance];
    [client favorite:[tweet id] success:^(id responseObject) {
        NSLog(@"Sucess");
    } failure:^(NSError *error) {
        NSLog(@"error");
        
    }];
}




@end
