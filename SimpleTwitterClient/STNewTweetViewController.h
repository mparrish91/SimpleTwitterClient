//
//  STNewTweetViewController.h
//  SimpleTwitterClient
//
//  Created by parry on 10/30/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STNewTweetViewController : UIViewController <UITextViewDelegate>

@property(strong,readwrite,nonatomic) UILabel *nameLabel;
@property(strong,readwrite,nonatomic) UILabel *usernameLabel;
@property(strong,readwrite,nonatomic) UIImageView *profilePhotoImageView;

@property(strong,readwrite,nonatomic) UITextView *tweetTextView;
@property(strong,readwrite,nonatomic) UILabel *textCountLabel;

@end
