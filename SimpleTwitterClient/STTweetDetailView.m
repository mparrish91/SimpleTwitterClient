//
//  STTweetDetailView.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STTweetDetailView.h"
#import "STTweet.h"
#import "UIImageView+AFNetworking.h"

@implementation STTweetDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithTweet:(STTweet *)tweet
{
    if (!(self = [super init]))
        return nil;
    
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self
                                        options:nil] objectAtIndex:0];
    self.retweetLabel.text = [tweet retweetName];
    self.nameLabel.text = [tweet accountName];
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@",[tweet userName]];
    self.timeLabel.text = [self convertDate:[tweet timestamp]];
    self.tweetTextLabel.text = [tweet text];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%@",[tweet retweetCount]];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%@",[tweet favoritesCount]];

    if (!tweet.retweet)
    {
        self.retweetLabel.hidden = true;
        self.retweetImageView.hidden = true;
    }
    
    self.tweetTextLabel.text = [tweet text];
    
    
    NSURL *photoImageURL = [NSURL URLWithString:[tweet avatarImagePath]];
    
    [self.profilePhotoImageView setImageWithURL:photoImageURL];


    self.profilePhotoImageView.layer.cornerRadius = 8;
    self.profilePhotoImageView.clipsToBounds = YES;
    [self.likeButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.replyButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.likeButton.imageView setContentMode:UIViewContentModeScaleAspectFit];

    
    return self;
}


- (NSString *)convertDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy, H:mm a"];
    NSString *resultString = [dateFormat stringFromDate:[NSDate date]];

    
    return resultString;
}

- (IBAction)onReplyButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(stTweetDetailReplyButtonDidChange:value:)]) {
        [self.delegate stTweetDetailReplyButtonDidChange:self.tweet value:true];
    }
}

- (IBAction)onRetweetButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(stTweetDetailReTweetButtonDidChange:value:)]) {
        [self.delegate stTweetDetailReTweetButtonDidChange:self.tweet value:true];
    }
     }

- (IBAction)onFavoriteButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(stTweetDetailFavoriteButtonDidChange:value:)]) {
        [self.delegate stTweetDetailFavoriteButtonDidChange:self.tweet value:true];
    }
    
         }

@end
