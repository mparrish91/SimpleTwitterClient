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

    if ([self.delegate respondsToSelector:@selector(stTweetCellReplyButtonDidChange:value:)]) {
        [self.delegate stTweetCellReplyButtonDidChange:self.tweet value:true];
    }


}

- (IBAction)onRetweetButtonPressed:(UIButton *)sender {
    sender.selected = ![sender isSelected];

    if ([self.delegate respondsToSelector:@selector(stTweetCellReTweetButtonDidChange:value:)]) {
        [self.delegate stTweetCellReTweetButtonDidChange:self.tweet value:true];
    }
}

- (IBAction)onFavoriteButtonPressed:(UIButton *)sender {
    sender.selected = ![sender isSelected];
    
    if ([self.delegate respondsToSelector:@selector(stTweetCellFavoriteButtonDidChange:value:)]) {
        [self.delegate stTweetCellFavoriteButtonDidChange:self.tweet value:true];
    }

}

@end
