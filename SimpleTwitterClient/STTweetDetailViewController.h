//
//  STTweetDetailViewController.h
//  SimpleTwitterClient
//
//  Created by parry on 10/30/16.
//  Copyright © 2016 parry. All rights reserved.
//
#import "STTweet.h"

#import <UIKit/UIKit.h>
#import "STTweetDetailView.h"

@interface STTweetDetailViewController : UIViewController <STTweetDetailViewCellDelegate>

- (instancetype)initWithTweet:(STTweet *)tweet;

@end
