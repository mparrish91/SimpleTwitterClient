//
//  STTweetTableViewCell.h
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//
#import "STTweet.h"
#import <UIKit/UIKit.h>


@protocol STTweetTableViewCellDelegate;

@interface STTweetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property(strong,readwrite,nonatomic) STTweet *tweet;

@property(weak,nonatomic) id <STTweetTableViewCellDelegate> delegate;


@end




@protocol STTweetTableViewCellDelegate <NSObject>
@optional
- (void)stTweetCellReplyButtonDidChange:(STTweet *)tweet value: (BOOL)value;
- (void)stTweetCellFavoriteButtonDidChange:(STTweet *)tweet value: (BOOL)value;
- (void)stTweetCellReTweetButtonDidChange:(STTweet *)tweet value: (BOOL)value;

@end
