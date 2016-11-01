//
//  STTweetTableViewCell.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STTweetTableViewCell.h"
#import "STTwitterClient.h"

@implementation STTweetTableViewCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.profilePhotoImageView.layer.cornerRadius = 15;
    self.profilePhotoImageView.clipsToBounds = YES;
}
- (IBAction)onReplyButtonPressed:(UIButton *)sender {
    sender.selected = ![sender isSelected];

    NSString *id = self.tweet.id;

}

- (IBAction)onRetweetButtonPressed:(UIButton *)sender {
    sender.selected = ![sender isSelected];

}

- (IBAction)onFavoriteButtonPressed:(UIButton *)sender {
    
    
        sender.selected = ![sender isSelected];

//    [sender setSelected:YES];
//    [sender setImage:[UIImage imageNamed: @"twitter_like_on"] forState:UIControlStateNormal];
//    [sender setImage:[UIImage imageNamed: "twitter_like_on"] forState:UIControlStateSelected];
//    [sender setImage:[UIImage imageNamed: "twitter_like_on"] forState:UIControlStateHighlighted ];

}

@end
