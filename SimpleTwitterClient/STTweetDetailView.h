//
//  STTweetDetailView.h
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//
#import "STTweet.h"
#import <UIKit/UIKit.h>

@protocol STTweetDetailViewCellDelegate;


@interface STTweetDetailView : UIView

@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property(strong,readwrite,nonatomic) STTweet *tweet;


- (instancetype)initWithTweet:(STTweet *)tweet;

@property(weak,nonatomic) id <STTweetDetailViewCellDelegate> delegate;



@end


@protocol STTweetDetailViewCellDelegate <NSObject>
@optional
- (void)stTweetDetailReplyButtonDidChange:(STTweet *)tweet value: (BOOL)value;
- (void)stTweetDetailFavoriteButtonDidChange:(STTweet *)tweet value: (BOOL)value;
- (void)stTweetDetailReTweetButtonDidChange:(STTweet *)tweet value: (BOOL)value;

@end
