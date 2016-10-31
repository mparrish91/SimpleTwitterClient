//
//  STTweetTableViewCell.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STTweetTableViewCell.h"

@implementation STTweetTableViewCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.profilePhotoImageView.layer.cornerRadius = 15;
    self.profilePhotoImageView.clipsToBounds = YES;
}

@end
