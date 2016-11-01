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
- (IBAction)onReplyButtonPressed:(id)sender {
    

}

- (IBAction)onRetweetButtonPressed:(id)sender {
    STTwitterClient *client = [STTwitterClient sharedInstance];
    [client reTweet:<#(NSString *)#> success:<#^(id responseObject)success#> failure:<#^(NSError *error)failure#>

}

- (IBAction)onFavoriteButtonPressed:(id)sender {
    STTwitterClient *client = [STTwitterClient sharedInstance];
    [client login:^(id responseObject) {

}

@end
